import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/signup/signup_cubit.dart';
import '../../../cubit/signup/signup_state.dart';
import '../../../models/user_model.dart';
import '../../../models/volunteer_model.dart';
import '../../../repositories/api/user_repository.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/picture_signup.dart';
import '../../volunteers/navigation_volunteer.dart';
import '../navigation_association.dart';

class PictureInscription extends StatefulWidget {
  Association? association;
  Volunteer? volunteer;

  PictureInscription({super.key, this.volunteer, this.association});

  @override
  State<PictureInscription> createState() => _PictureInscriptionState();
}

class _PictureInscriptionState extends State<PictureInscription> {
  Uint8List? _imageProfile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<VolunteerCubit>();
      cubit.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) async {
      if (state is SignupPictureState) {
        if (widget.association != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Votre photo de profil a été mise à jour"),
            ),
          );
          _imageProfile = state.imageProfile;
          BlocProvider.of<AssociationCubit>(context).initState();
        }
        if (widget.volunteer != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Votre photo de profil a été mise à jour"),
            ),
          );
          _imageProfile = state.imageProfile;
          BlocProvider.of<VolunteerCubit>(context).initState();
        }
      }

      if (state is SignupCreatedAssociationState) {
        print(state.associationModel.email);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        String? id = widget.association?.id;
        preferences.setBool('Association', true);
        preferences.setString('idAssociation', id!);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  NavigationAssociation(),
              transitionDuration: Duration(milliseconds: 1),
              reverseTransitionDuration: Duration(milliseconds: 1),
            ),
          );
        });
      }
      if (state is SignupCreatedVolunteerState) {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setBool('Volunteer', true);
        preferences.setString('idVolunteer', state.volunteerModel.id!);
        print(state.volunteerModel.id!);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NavigationVolunteer(volunteer: state.volunteerModel),
            ),
          );
        });
      }

      if (state is AssociationErrorState) {
        final snackBar = SnackBar(
          content: const Text(
              'Une erreur est survenue lors de la création de votre compte'),
          action: SnackBarAction(
            label: 'Annuler',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background1.png"),
                          fit: BoxFit.cover)),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthAppBar(contexts: context),
                      Divider(
                        color: Colors.grey.shade400,
                        endIndent: MediaQuery.of(context).size.height * .04,
                        indent: MediaQuery.of(context).size.height * .04,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Inscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .06,
                          color: Color.fromRGBO(235, 126, 26, 1),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                          'Définissez votre photo de profil',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      PictureSignup(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () async {
                            if (widget.association != null) {
                              Association association = Association(
                                name: widget.association!.name,
                                type: widget.association!.type,
                                phone: widget.association!.phone,
                                location: widget.association!.location,
                                imageProfile: '',
                                bio: widget.association!.bio,
                                email: widget.association!.email,
                                id: widget.association!.id,
                              );
                              String? email = widget.association!.email;
                              UserModel userModel =
                                  await UserRepository().getUserByEmail(email!);
                              UserModel userModel2 = UserModel.fromJson({
                                "id": userModel.id,
                                "email": userModel.email,
                                "isConnect": true,
                                "isVerified": true,
                                "isActif": true,
                                "rule": {
                                  "id": userModel.id,
                                  "rulesType": "USER_ASSOCIATION"
                                }
                              });
                              UserRepository()
                                  .updateUser(userModel2)
                                  .then((value) {
                                BlocProvider.of<SignupCubit>(context)
                                    .createAssociation(association);
                                BlocProvider.of<SignupCubit>(context)
                                    .changeState(SignupCreatedAssociationState(
                                        associationModel: association));
                              });
                            }
                            if (widget.volunteer != null) {
                              Volunteer volunteer = Volunteer(
                                firstName: widget.volunteer!.firstName,
                                lastName: widget.volunteer!.lastName,
                                phone: widget.volunteer!.phone,
                                birthDayDate: widget.volunteer!.birthDayDate,
                                imageProfile: '',
                                bio: widget.volunteer!.bio,
                                email: widget.volunteer!.email,
                                id: widget.volunteer!.id,
                                myAssociations: [],
                                myAssociationsWaiting: [],
                                location: widget.volunteer!.location,
                              );
                              String? email = widget.volunteer!.email;
                              UserModel userModel =
                                  await UserRepository().getUserByEmail(email!);
                              UserModel userModel2 = UserModel.fromJson({
                                "id": userModel.id,
                                "email": userModel.email,
                                "isConnect": true,
                                "isVerified": true,
                                "isActif": true,
                                "rule": {
                                  "id": userModel.id,
                                  "rulesType": "USER_VOLUNTEER"
                                }
                              });
                              UserRepository()
                                  .updateUser(userModel2)
                                  .then((value) {
                                BlocProvider.of<SignupCubit>(context)
                                    .createVolunteer(volunteer);
                                BlocProvider.of<SignupCubit>(context)
                                    .changeState(SignupCreatedVolunteerState(
                                        volunteerModel: volunteer));
                              });
                            }
                          },
                          child: Text(
                            "Ingnorer cette étape",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              color: Colors.black87,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                            "Votre photo de profile sera visible par les associations. Vous pourrez le modifier quand vous le souhaitez.",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .03,
                              color: Colors.black87,
                            )),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.60,
                        padding: EdgeInsets.only(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (widget.association != null) {
                              Association association = Association(
                                name: widget.association!.name,
                                type: widget.association!.type,
                                phone: widget.association!.phone,
                                location: widget.association!.location,
                                bio: widget.association!.bio,
                                email: widget.association!.email,
                                id: widget.association!.id,
                              );
                              String? email = widget.association!.email;
                              UserModel userModel =
                                  await UserRepository().getUserByEmail(email!);
                              UserModel userModel2 = UserModel.fromJson({
                                "id": userModel.id,
                                "email": userModel.email,
                                "isConnect": true,
                                "isVerified": true,
                                "isActif": true,
                                "rule": {
                                  "id": userModel.id,
                                  "rulesType": "USER_ASSOCIATION"
                                }
                              });

                              if (_imageProfile != null) {
                                association.imageProfile =
                                    base64Encode(_imageProfile!);
                              } else {
                                association.imageProfile = '';
                              }
                              UserRepository()
                                  .updateUser(userModel2)
                                  .then((value) {
                                BlocProvider.of<SignupCubit>(context)
                                    .createAssociation(association);
                                BlocProvider.of<SignupCubit>(context)
                                    .changeState(SignupCreatedAssociationState(
                                        associationModel: association));
                              });
                            }
                            if (widget.volunteer != null) {
                              Volunteer volunteer = Volunteer(
                                firstName: widget.volunteer!.firstName,
                                lastName: widget.volunteer!.lastName,
                                phone: widget.volunteer!.phone,
                                birthDayDate: widget.volunteer!.birthDayDate,
                                bio: widget.volunteer!.bio,
                                email: widget.volunteer!.email,
                                id: widget.volunteer!.id,
                                myAssociations: [],
                                myAssociationsWaiting: [],
                                location: widget.volunteer!.location,
                              );
                              if (_imageProfile != null) {
                                volunteer.imageProfile =
                                    base64Encode(_imageProfile!);
                              } else {
                                volunteer.imageProfile = '';
                              }

                              String? email = widget.volunteer!.email;
                              UserModel userModel =
                                  await UserRepository().getUserByEmail(email!);
                              UserModel userModel2 = UserModel.fromJson({
                                "id": userModel.id,
                                "email": userModel.email,
                                "isConnect": true,
                                "isVerified": true,
                                "isActif": true,
                                "rule": {
                                  "id": userModel.id,
                                  "rulesType": "USER_VOLUNTEER"
                                }
                              });
                              UserRepository()
                                  .updateUser(userModel2)
                                  .then((value) {
                                BlocProvider.of<SignupCubit>(context)
                                    .createVolunteer(volunteer);
                                BlocProvider.of<SignupCubit>(context)
                                    .changeState(SignupCreatedVolunteerState(
                                        volunteerModel: volunteer));
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Terminer",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

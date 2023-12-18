import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/navigation_bar.dart';
import 'package:namer_app/widgets/image_picker.dart';

import '../../../widgets/auth_app_bar.dart';
import '../navigation_association.dart';

class PictureInscription extends StatefulWidget {
  final String nameAssociation;
  final String typeAssociation;
  final String phoneNumber;
  final String bio;
  final String address;
  final String city;
  final String zipcode;
  final String email;
  final String id;

  PictureInscription(
      {super.key,
      required this.phoneNumber,
      required this.bio,
      required this.address,
      required this.city,
      required this.zipcode,
      required this.nameAssociation,
      required this.typeAssociation, required this.email, required this.id});

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
    return BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
      if (state is AssociationPictureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Votre photo de profil a été mise à jour"),
          ),
        );
        _imageProfile = state.imageProfile;
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
                      _pictureAssociation(context, state),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () {
                            final cubit = context.read<AssociationCubit>();
                            Association association = Association(
                              name: widget.nameAssociation,
                              type: widget.typeAssociation,
                              phone: widget.phoneNumber,
                              address: widget.address,
                              city: widget.city,
                              imageProfile: '',
                              bio: widget.bio,
                              email: widget.email,
                              id: widget.id,
                            );
                            BlocProvider.of<AssociationCubit>(context)
                                .createAssociation(association);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationExample(),
                                ),
                              );
                            });
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
                            final cubit = context.read<AssociationCubit>();
                            Association association = Association(
                              name: widget.nameAssociation,
                              type: widget.typeAssociation,
                              phone: widget.phoneNumber,
                              address: widget.address,
                              city: widget.city,
                              imageProfile: base64Encode(_imageProfile!),
                              bio: widget.bio,
                              email: widget.email,
                              id: widget.id,
                            );
                            print(association);
                            print("+++++++++++++++++++++++++++" + association.id.toString());
                            BlocProvider.of<AssociationCubit>(context)
                                .createAssociation(association);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationAssociation(),
                                ),
                              );
                            });
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

  Widget _pictureAssociation(BuildContext context, state) {
    double padding = MediaQuery.of(context).size.height * .009 / 4;

    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .35,
          child: Card(
            margin: const EdgeInsets.all(5),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
            color: Colors.white.withOpacity(0.8),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: MyImagePicker(rulesType: RulesType.USER_ASSOCIATION),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/views/associtions/signup/picture_inscription.dart';

import '../../../cubit/association/association_state.dart';
import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../models/association_model.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/signup/bio.dart';

class BioAssociationInscription extends StatefulWidget {
  final String nameAssociation;
  final String typeAssociation;
  final String phoneNumber;
  final LocationModel location;
  final String id;
  final String email;

  const BioAssociationInscription(
      {super.key,
      required this.location,
      required this.nameAssociation,
      required this.typeAssociation,
      required this.phoneNumber, required this.id, required this.email});

  @override
  State<BioAssociationInscription> createState() =>
      _BioAssociationInscriptionState();
}

class _BioAssociationInscriptionState extends State<BioAssociationInscription> {
  late String _bio = "";

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
      final cubit = context.read<AssociationCubit>();
      cubit.initState();
    });
  }

  void _handleBioChanges(String? bio) async {
    setState(() {
      _bio = bio!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
      if (state is AssociationInfoState) {
        Association association = Association(
          name: state.name,
          type: state.type,
          phone: state.phone,
          location: state.location,
          bio: state.bio,
          id: widget.id,
          email: widget.email,
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PictureInscription(
                association: association,
              ),
            ),
          ); // ici mettre la page d'inscription
        });
      }

      if (state is VolunteerErrorState) {
        final snackBar = SnackBar(
          content: const Text(
              'Une erreur est survenue lors de la création de votre compte, veuillez réessayer ultérieurement'),
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
            resizeToAvoidBottomInset: true,
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
                          'Décrivez-vous en quelques mots pour que les autres utilisateurs puissent vous connaître',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      BioSignup(
                        onBioChanged: _handleBioChanges,
                        isEditing: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () {
                            final cubit = context.read<AssociationCubit>();
                            cubit.changeState(
                              AssociationInfoState(
                                name: widget.nameAssociation,
                                type: widget.typeAssociation,
                                phone: widget.phoneNumber,
                                location: widget.location,
                                bio: "",
                              ),
                            );
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
                            "Votre nom d’utilisateur sera visible sur votre profil. Vous pourrez le modifier quand vous le souhaitez.",
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
                            cubit.changeState(
                              AssociationInfoState(
                                name: widget.nameAssociation,
                                type: widget.typeAssociation,
                                phone: widget.phoneNumber,
                                location: widget.location,
                                bio: _bio,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Continuer",
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

// UserCreatedState

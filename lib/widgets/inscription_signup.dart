import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/views/volunteers/signup/infos_inscription.dart';

import '../cubit/user/user_cubit.dart';
import '../cubit/user/user_state.dart';
import '../type/rules_type.dart';
import '../views/associtions/signup/inscription_assocition_signup.dart';
import '../views/common/authentification/repository/auth_repository.dart';
import 'auth_app_bar.dart';

class InscriptionDemarche extends StatelessWidget {
  final String mdp;
  final RulesType title;
  final String email;
  final String id;

  InscriptionDemarche(
      {required this.mdp,
      required this.title,
      required this.email,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserRegisterErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de l'inscription"),
          ),
        );
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
                      AuthAppBar(
                        contexts: context,
                      ),
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
                      Text(
                        'Vérifiez votre adresse mail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            bool? isEmailVerified =
                                await AuthRepository().verifiedEmail();

                            if (isEmailVerified) {
                              BlocProvider.of<UserCubit>(context)
                                  .createUserType(title, email, mdp);
                              if (title == RulesType.USER_VOLUNTEER) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                          InfosInscriptionVolunteer(
                                        email: email,
                                        id: id,
                                      ),
                                    ),
                                  );
                                });
                              } else if (title == RulesType.USER_ASSOCIATION) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                          InscriptionAssociation(
                                        email: email,
                                        id: id,
                                      ),
                                    ),
                                  ); // Pas nécessaire de mettre cette partie dans addPostFrameCallback
                                });
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Votre adresse mail n\'est encore pas vérifié, veuillez régader votre boite mail '),
                                action: SnackBarAction(
                                  label: 'Annuler',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text("J'ai vérifié mon adresse"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Ajustez l'alignement selon vos besoins

                          children: <Widget>[
                            Text("Je n'ai pas reçu mon mail, "),
                            TextButton(
                              onPressed: () async {
                                bool verify = await AuthRepository()
                                    .sendEmailVerification();

                                if (verify == false) {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Votre adresse mail de vérification a été déja envoyé vérifiez votre boite mail'),
                                    action: SnackBarAction(
                                      label: 'Annuler',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Votre nouveau mail de vérification a été envoyé vérifiez votre boite mail'),
                                    action: SnackBarAction(
                                      label: 'Annuler',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text(
                                "renvoyez-moi",
                                style: TextStyle(
                                  decoration: TextDecoration
                                      .underline, // Souligne le texte
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                if (state is UserLoadingState) _buildLoading(context, state),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLoading(BuildContext context, UserLoadingState state) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Fond semi-transparent noir
      width: double.infinity, // Couvre toute la largeur
      height: MediaQuery.of(context).size.height, // Couvre toute la hauteur
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


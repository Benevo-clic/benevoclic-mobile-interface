import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/repositories/api/user_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/forgotten_password.dart';
import 'package:namer_app/views/common/authentification/login/widgets/customTextFormField_widget.dart';
import 'package:namer_app/views/common/profiles/widget/pop_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../repositories/google/auth_repository.dart';
import '../../../../../util/errorFirebase.dart';
import '../../../../../util/showDialog.dart';
import '../../../../../widgets/inscription_signup.dart';
import '../../../../associtions/navigation_association.dart';
import '../../../../associtions/signup/inscription_assocition_signup.dart';
import '../../../../volunteers/navigation_volunteer.dart';
import '../../../../volunteers/signup/infos_inscription.dart';

class FormulaireLogin extends StatefulWidget {
  final RulesType rulesType;

  const FormulaireLogin({super.key, required this.rulesType});

  @override
  State<FormulaireLogin> createState() => _FormulaireLoginState();
}

class _FormulaireLoginState extends State<FormulaireLogin> {
  late String _email;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).changeState(UserInitialState());
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    try {
      await AuthRepository()
          .signInWithEmailAndPassword(_email.toString(), _password.toString());

      User? user = await AuthRepository().getCurrentUser();
      bool isEmailVerified = await AuthRepository().isEmailVerified();

      if (isEmailVerified == false) {
        ShowDialogYesNo.show(
          context,
          "Votre email n'est pas vérifié",
          "Voulez-vous recevoir un email de vérification ?",
          () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InscriptionDemarche(
                  email: _email,
                  mdp: _password,
                  title: widget.rulesType,
                  id: user!.uid,
                ),
              ),
            );
          },
        );
      } else {
        UserModel userModel = await UserRepository().getUserByEmail(_email);
        BlocProvider.of<UserCubit>(context).connexion(userModel);
        if (!userModel.isActif) {
          ShowDialogYesNo.show(
            context,
            "Votre compte n'est pas actif",
            "Vous voulez activer votre compte ?",
            () async {
              if (userModel.rule.rulesType == RulesType.USER_ASSOCIATION) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InscriptionAssociation(
                      email: _email,
                      id: user!.uid,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfosInscriptionVolunteer(
                      email: _email,
                      id: user!.uid,
                    ),
                  ),
                );
              }
            },
          );
        } else if (!userModel.isConnect &&
            (userModel.rule.rulesType == widget.rulesType)) {
          BlocProvider.of<UserCubit>(context).connexion(userModel);
          SnackBar snackBar = SnackBar(
            content: Text("Connexion réussi"),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } on FirebaseAuthException catch (e) {
      ErrorFirebase.errorCheck(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is ResponseUserState &&
          state.user.rule.rulesType == widget.rulesType) {
        _navigateToNextPage(context, state.user.rule.rulesType, state.user.id);
      } else if (state is UserErrorState) {
        ShowDialog.show(context, "Erreur de connexion", "retour");
      }
    }, builder: (context, state) {
      return Stack(
        children: [
          Card(
            margin: const EdgeInsets.all(30),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hintText: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          prefixIcons: true,
                          maxLine: 1,
                          onSaved: (value) {
                            _email = value.toString();
                          },
                          validator: (value) {
                            var regexp = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value == null ||
                                !regexp.hasMatch(value.toString())) {
                              return "Votre email n'est pas valide";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hintText: "Password",
                          icon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          prefixIcons: true,
                          maxLine: 1,
                          onSaved: (value) {
                            _password = value.toString();
                          },
                          validator: (value) {
                            var regex = RegExp(r"^.{8,}$");
                            if (value == null ||
                                !regex.hasMatch(value.toString())) {
                              return "Votre password n'est pas valide";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          if (widget.rulesType == RulesType.USER_ASSOCIATION) {
                            return PopDialog(
                              content: ForgottenPassword(
                                  roleType: RulesType.USER_ASSOCIATION),
                            );
                          } else {
                            return PopDialog(
                              content: ForgottenPassword(
                                roleType: RulesType.USER_VOLUNTEER,
                              ),
                            );
                          }
                        });
                  },
                  child: Text(
                    "Mot de passe oublié ?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.60,
                  padding: EdgeInsets.only(),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(170, 77, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      await _submit();
                    },
                    child: const Text("Connexion",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size(0, 15),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

Future<void> _navigateToNextPage(
    BuildContext context, RulesType rulesType, id) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  if (rulesType == RulesType.USER_ASSOCIATION) {
    preferences.setBool('Association', true);
    preferences.setString('idAssociation', id);
    BlocProvider.of<AssociationCubit>(context).getAssociation(id);
  } else if (rulesType == RulesType.USER_VOLUNTEER) {
    preferences.setBool('Volunteer', true);
    preferences.setString('idVolunteer', id);
    BlocProvider.of<VolunteerCubit>(context).getVolunteer(id);
  }

  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            rulesType == RulesType.USER_ASSOCIATION
                ? NavigationAssociation()
                : NavigationVolunteer(),
        transitionDuration: Duration(milliseconds: 1),
        reverseTransitionDuration: Duration(milliseconds: 1),
      ));
}

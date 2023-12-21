import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/repositories/api/user_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/customTextFormField_widget.dart';

import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../util/showDialog.dart';
import '../../../../../widgets/inscription_signup.dart';
import '../../../../associtions/navigation_association.dart';
import '../../../../associtions/signup/inscription_assocition_signup.dart';
import '../../../../volunteers/navigation_volunteer.dart';
import '../../../../volunteers/signup/infos_inscription.dart';
import '../../repository/auth_repository.dart';

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

  Future<void> _submit() async {
      _formKey.currentState!.save();
      try {
        await AuthRepository()
            .authAdressPassword(_email.toString(), _password.toString());

      User user = FirebaseAuth.instance.currentUser!;

      if (user.emailVerified == false) {
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
                  id: user.uid,
                ),
              ),
            );
          },
        );
      } else {
        UserModel userModel = await UserRepository().getUserByEmail(_email);
        if (userModel.isConnect) {
          ShowDialog.show(context, "Vous êtes déjà connecté", "retour");
        } else if (!userModel.isActif) {
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
                      id: user.uid,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfosInscriptionVolunteer(
                      email: _email,
                      id: user.uid,
                    ),
                  ),
                );
              }
            },
          );
        } else if (!userModel.isConnect &&
            (userModel.rule.rulesType == widget.rulesType)) {
          BlocProvider.of<UserCubit>(context).connexion();
          SnackBar snackBar = SnackBar(
            content: Text("Connexion réussi"),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } on FirebaseAuthException catch (_) {
      ShowDialog.show(context, "login incorrect", "retour");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is ResponseUserState &&
          state.user.rule.rulesType == widget.rulesType) {
        _navigateToNextPage(context, state.user.rule.rulesType);
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
                    ShowDialog.show(
                        context, "cette fonctionalité arrive !!", "retour");
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
          if (state is UserInitialState) _buildInitialInput(),
        ],
      );
    });
  }
}

void _navigateToNextPage(BuildContext context, RulesType rulesType) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return rulesType == RulesType.USER_ASSOCIATION
        ? NavigationAssociation()
        : NavigationVolunteer();
  }));
}

Widget _buildInitialInput() {
  return const Center(
    child: Text(''),
  );
}


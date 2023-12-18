import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/showDialog.dart';

import '../cubit/user/user_cubit.dart';
import '../cubit/user/user_state.dart';
import '../views/common/authentification/login/widgets/customTextFormField_widget.dart';
import 'inscription_volunteer_signup.dart';

class SignupForm extends StatefulWidget {
  final RulesType rulesType;

  const SignupForm({super.key, required this.rulesType});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late String _email;
  late String _password;
  late String _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<UserCubit>();
      cubit.formRegister();
    });
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    try {
      if (_password == _confirmPassword) {
        BlocProvider.of<UserCubit>(context).createUser(_email, _password);
      } else {
        ShowDialog.show(
            context, "Les mots de passe ne sont pas identiques", "retour");
      }
    } on FirebaseAuthException catch (_) {
      ShowDialog.show(context, "inscription incorrect", "retour");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserEmailVerificationState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InscriptionDemarche(
                address: _email.toString(),
                mdp: _password.toString(),
                title: widget.rulesType,
              ),
            ),
          ); // ici mettre la page d'inscription
        });
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
                          maxLine: 1,
                          prefixIcons: true,
                          onSaved: (value) {
                            _password = value.toString();
                          },
                          validator: (value) {
                            var regex = RegExp(r"^.{8,}$");
                            if (value == null) {
                              return "Votre password n'est pas valide";
                            } else if (value.toString().contains(" ")) {
                              return "Votre password ne doit pas contenir d'espace";
                            } else if (!regex.hasMatch(value.toString())) {
                              return "Votre password doit contenir au moins 8 caractères";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hintText: "Confirmer votre password",
                          icon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          maxLine: 1,
                          prefixIcons: true,
                          onSaved: (value) {
                            _confirmPassword = value.toString();
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
                SizedBox.fromSize(
                  size: const Size(0, 15),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 33, right: 10, bottom: 10, top: 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "En vous inscrivant, vous acceptez les "),
                          TextSpan(
                            text: "conditions générales d'utilisation",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                ShowDialog.show(context,
                                    "cette fonctionalité arrive !!", "retour");
                              },
                          ),
                        ],
                      ),
                    )),
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
                    child: const Text("S'inscrire",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ShowDialog.show(
                        context, "cette fonctionalité arrive !!", "retour");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Vous avez déjà un compte ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * .03,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Connectez-vous",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: MediaQuery.of(context).size.width * .03,
                              color: Colors.blueAccent),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (state is UserInitialState) _buildInitialInput(),
        ],
      );
    });
  }

  Widget _buildInitialInput() {
    return const Center(
      child: Text(''),
    );
  }
}


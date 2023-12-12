import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../cubit/user/user_state.dart';
import '../../../error/error_message.dart';
import '../../../util/email_verification.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import '../../common/authentification/repository/auth_repository.dart';
import 'inscription.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late String _email;
  late String _password;
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
      BlocProvider.of<UserCubit>(context).createUser(_email, _password);
    } on FirebaseAuthException catch (_) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorMessage(
                type: "inscription incorrect", message: "retour");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
      if (state is UserRegisterState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InscriptionDemarche(
                adress: _email.toString(),
                mdp: _password.toString(),
                title: RulesType.USER_VOLUNTEER,
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
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hintText: "Confirmer votre password",
                          icon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
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
                SizedBox.fromSize(
                  size: const Size(0, 15),
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
                    child: const Text("S'inscrire",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorMessage(
                            type: "cette fonctionalité arrive !!",
                            message: "retour");
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous avez déjà un compte ?",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        " Connectez-vous",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (state is UserInitialState) _buildInitialInput(),
          if (state is UserErrorState) _buildError(),
        ],
      );
    });
  }

  Widget _buildError() {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text('Erreur de connexion'),
      ),
    );
  }

  Widget _buildInitialInput() {
    return const Center(
      child: Text(''),
    );
  }
}

class FormulaireInscription extends StatefulWidget {
  const FormulaireInscription({super.key});

  @override
  State<FormulaireInscription> createState() => _FormulaireInscriptionState();
}

class _FormulaireInscriptionState extends State<FormulaireInscription> {
  final myController = TextEditingController();

  var _adress;
  var _mdp;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.deepOrange, width: 2)),
      padding: EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width * .85,
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              var email = EmailVerification(value.toString());
              if (email.security()) {
                setState(() {
                  _adress = value;
                });
                return null;
              } else {
                return email.message;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Adresse mail ou numéro de téléphone',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez rentrer un mot de passe";
              } else {
                setState(() {
                  _mdp = value;
                });
                return null;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.key_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Créez votre mot de passe',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.key_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Confirmez votre mot de passe',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.60,
            padding: EdgeInsets.only(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(150, 62, 96, 1),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    AuthRepository().createAccount(_adress, _mdp);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InscriptionDemarche(
                          adress: _adress.toString(),
                          mdp: _mdp.toString(),
                          title: RulesType.USER_VOLUNTEER,
                        ),
                      ),
                    );
                  } on FirebaseAuthException catch (_) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ErrorMessage(
                              type: "inscription incorrect", message: "retour");
                        });
                  }
                }
              },
              child: const Text("Inscription",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Vous avez déjà un compte ?",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}

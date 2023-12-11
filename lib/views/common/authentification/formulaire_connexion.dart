import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/views/common/authentification/widgets/customTextFormField_widget.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../error/error_message.dart';
import '../../../util/email_verification.dart';
import '../../navigation_bar.dart';
import 'repository/auth_repository.dart';

class FormulaireLogin extends StatefulWidget {
  const FormulaireLogin({super.key});

  @override
  State<FormulaireLogin> createState() => _FormulaireLoginState();
}

class _FormulaireLoginState extends State<FormulaireLogin> {
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
      cubit.formLogin();
    });
  }

  String? verifEmail(String value) {
    var email = EmailVerification(value);
    if (email.security()) {
      setState(() {
        _email = value;
      });
      return _email;
    } else {
      return email.message;
    }
  }

  String verifPassword(String value) {
    if (value.isEmpty || value == null) {
      return "Veuillez rentrer un mot de passe";
    } else {
      setState(() {
        _password = value;
      });
      return _password;
    }
  }

  Future<void> _submit() async {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
      try {
        await AuthRepository()
            .authAdressPassword(_email.toString(), _password.toString());
        BlocProvider.of<UserCubit>(context).connexion();
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorMessage(type: "login incorrect", message: "retour");
          },
        );
        print(e.code);
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
      if (state is ResponseUserState) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationExample()));
          final cubit = context.read<UserCubit>();
          cubit.userConnexion(state.user);
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
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value == null ||
                                !regexp.hasMatch(value.toString())) {
                              return "Veuillez rentrer un email valide";
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
                              return "Le mot de passe doit contenir au moins 8 caractères";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
          if (state is UserErrorState) _buildError(),
        ],
      );
    });
  }
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


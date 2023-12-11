import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';

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
  final myController = TextEditingController();

  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30),
      shadowColor: Colors.grey,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: false,
                  validator: (value) {
                    var email = EmailVerification(value.toString());
                    if (email.security()) {
                      setState(() {
                        _email = value;
                      });
                      return null;
                    } else {
                      return email.message;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer un mot de passe";
                    } else {
                      setState(() {
                        _password = value;
                      });
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
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
              SizedBox(
                height: 5,
              ),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserInitialState) {
                    return _buildInitialInput();
                  } else if (state is UserLoadingState) {
                    return _buildLoading(context, state);
                  } else if (state is ResponseUserState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationExample()));
                      final cubit = context.read<UserCubit>();
                      cubit.userConnexion(state.user);
                    });
                    return Text("Connexion réussie");
                  } else if (state is UserErrorState) {
                    return _buildError();
                  }
                  return Text('Unknown state: $state');
                },
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.60,
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(170, 77, 79, 1),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await AuthRepository().authAdressPassword(
                            _email.toString(), _password.toString());
                        BlocProvider.of<UserCubit>(context).connexion();
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorMessage(
                                type: "login incorrect", message: "retour");
                          },
                        );
                        print(e.code);
                      }
                    }
                  },
                  child: const Text("Connexion",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLoading(BuildContext context, UserLoadingState state) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildInitialInput() {
  return const Center(
    child: Text(''),
  );
}

Widget _buildError() {
  return const Center(
    child: Text('Errorsssssssssss'),
  );
}

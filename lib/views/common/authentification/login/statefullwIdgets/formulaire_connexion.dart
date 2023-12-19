import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/customTextFormField_widget.dart';

import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../util/showDialog.dart';
import '../../../../associtions/navigation_association.dart';
import '../../../../volunteers/navigation_volunteer.dart';
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

  Future<void> _submit() async {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
      try {
        await AuthRepository()
            .authAdressPassword(_email.toString(), _password.toString());
        BlocProvider.of<UserCubit>(context).connexion();
    } on FirebaseAuthException catch (_) {
      ShowDialog.show(context, "login incorrect", "retour");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is ResponseUserState) {
        if (widget.rulesType == RulesType.USER_ASSOCIATION) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationAssociation()));
            final cubit = context.read<UserCubit>();
            cubit.userConnexion(state.user);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NavigationVolunteer()));
            final cubit = context.read<UserCubit>();
            cubit.userConnexion(state.user);
          });
        }
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

Widget _buildInitialInput() {
  return const Center(
    child: Text(''),
  );
}


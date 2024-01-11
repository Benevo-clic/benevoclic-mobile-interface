import 'package:flutter/material.dart';
import 'package:namer_app/repositories/google/auth_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/util/email_verification.dart';
import 'package:namer_app/widgets/button.dart';

class ForgottenPassword extends StatelessWidget {
  final RulesType roleType;

  ForgottenPassword({super.key, required this.roleType});

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Entrez votre adresse mail ci-dessous"),
          TextFormField(
            validator: (value) {
              EmailVerification ev = EmailVerification(value!);
              if (ev.security()) {
                return null;
              } else {
                return ev.message;
              }
            },
            controller: _controller,
          ),
          SizedBox(
            height: 15,
          ),
          Button(
              text: "Réinitiliser le mot de passe",
              color: Colors.white,
              fct: () {
                if (_formKey.currentState!.validate()) {
                  AuthRepository().forgotPassword(_controller.text);
                }
              },
              backgroundColor: marron)
        ],
      ),
    );
  }
}

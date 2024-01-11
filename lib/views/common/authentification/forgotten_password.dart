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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Entrez votre adresse mail ci-dessous"),
            SizedBox(height: 8),
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Entrez votre email',
              ),
            ),
            SizedBox(height: 15),
            Button(
                text: "Réinitiliser le mot de passe",
                color: Colors.white,
                fct: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await AuthRepository().forgotPassword(_controller.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Email de réinitialisation envoyé. Veuillez vérifier votre boîte de réception."),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Votre email n'est pas valide."),
                        ),
                      );
                    }
                  }
                },
                backgroundColor: marron),
          ],
        ),
      ),
    );
  }
}

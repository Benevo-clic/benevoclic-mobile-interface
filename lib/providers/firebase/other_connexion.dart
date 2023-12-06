import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/providers/firebase/auth.dart';

class OtherConnection extends StatelessWidget {
  final BuildContext context;

  final String label;
  final FaIcon icon;

  const OtherConnection(this.context, this.label, this.icon);

  @override
  Widget build(Object context) {
    return Container(
      padding: EdgeInsets.only(),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.shade300),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ))),
        onPressed: () async {
          authGmail();
        },
        child: Row(
          children: [
            icon,
            SizedBox(width: 5),
            Expanded(child: Text(label, style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}

authGmail() async {
  await AuthService().singInWithGoogle();
}

authFacebook() async {}

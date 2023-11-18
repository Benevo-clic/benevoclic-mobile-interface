import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/login.dart';
import 'package:namer_app/services/auth.dart';

import 'pages/navigationBarApp.dart';

class LoginController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().userChanged,
      builder: (context, snapshot) {
        return (snapshot.data?.emailVerified == true) ? NavigationExample() : LoginPage();
      },
    );
  }
}

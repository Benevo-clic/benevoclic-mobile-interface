import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/login.dart';
import 'package:namer_app/services/auth.dart';

import 'navigationBarApp.dart';

class LoginController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().userChanged,
      builder: (context, snapshot) {
        return snapshot.data != null ? NavigationExample() : LoginPage();
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Login.dart';
import 'package:namer_app/services/auth.dart';

import 'NavigationBarApp.dart';

class loginController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: AuthService().userChanged,
        builder: (context,snapshot) {
          return snapshot.data != null ? NavigationBarApp() : LoginPage();
      },
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserState {
}

class UserInitialState extends UserState {
}

class UserLoadingState extends UserState {
}

class ResponseUserState extends UserState {
  final String statusCode;
  ResponseUserState({required this.statusCode});
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}
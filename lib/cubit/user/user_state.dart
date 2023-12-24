import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/user_model.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class ResponseUserState extends UserState {
  final UserModel user;

  ResponseUserState({required this.user});
}

class UserCreatedState extends UserState {
  final String statusCode;

  UserCreatedState({required this.statusCode});
}

class UserRegisterState extends UserState {}

class UserDisconnectedState extends UserState {
  final String statusCode;

  UserDisconnectedState({required this.statusCode});
}

class UserRoleNotMatched extends UserState {}

class UserEmailVerificationState extends UserState {
  final User? user;

  UserEmailVerificationState({this.user});
}

class UserEmailGoggleVerificationState extends UserState {
  final User? user;

  UserEmailGoggleVerificationState({this.user});
}

class UserConnexionState extends UserState {
  final UserModel userModel;

  UserConnexionState({required this.userModel});
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}

class UserUpdateState extends UserState {
  final UserModel userModel;

  UserUpdateState({required this.userModel});
}

class UserRegisterErrorState extends UserState {
  final String message;

  UserRegisterErrorState({required this.message});
}

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

class UserConnexionState extends UserState {
  final UserModel userModel;

  UserConnexionState({required this.userModel});
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}

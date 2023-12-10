import 'package:flutter/material.dart';

@immutable
abstract class UserState {}

class UserLoginState extends UserState {}

class UserLogedState extends UserState {}

class UserCreatingState extends UserState {}


class ResponseUserState extends UserState {
  final String statusCode;
  ResponseUserState({required this.statusCode});
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}

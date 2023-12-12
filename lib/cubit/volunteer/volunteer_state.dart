import 'package:flutter/material.dart';

@immutable
abstract class VolunteerState {}

class VolunteerInitialState extends VolunteerState {}

class VolunteerLoadingState extends VolunteerState {}

class VolunteerCreatedState extends VolunteerState {
  final String statusCode;

  VolunteerCreatedState({required this.statusCode});
}

class VolunteerErrorState extends VolunteerState {
  final String message;

  VolunteerErrorState({required this.message});
}

class VolunteerUpdateState extends VolunteerState {
  final String statusCode;

  VolunteerUpdateState({required this.statusCode});
}

class VolunteerDeleteState extends VolunteerState {
  final String statusCode;

  VolunteerDeleteState({required this.statusCode});
}

class VolunteerGetState extends VolunteerState {
  final String statusCode;

  VolunteerGetState({required this.statusCode});
}

import 'package:flutter/material.dart';

import '../../models/volunteer_model.dart';

@immutable
abstract class VolunteerState {}

class VolunteerInitialState extends VolunteerState {}

class VolunteerLoadingState extends VolunteerState {}

class VolunteerCreatedState extends VolunteerState {
  final Volunteer volunteerModel;

  VolunteerCreatedState({required this.volunteerModel});
}

class VolunteerErrorState extends VolunteerState {
  final String message;

  VolunteerErrorState({required this.message});
}

class VolunteerInfoState extends VolunteerState {
  final String lastName;
  final String firstName;
  final String birthDate;
  final String phoneNumber;
  final String? bio;

  VolunteerInfoState({
    required this.lastName,
    required this.firstName,
    required this.birthDate,
    required this.phoneNumber,
    this.bio,
  });
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

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/volunteer_model.dart';

@immutable
abstract class VolunteerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VolunteerInitialState extends VolunteerState {}

class VolunteerLoadingState extends VolunteerState {}

class VolunteerCreatedState extends VolunteerState {
  final Volunteer volunteerModel;

  VolunteerCreatedState({required this.volunteerModel});

  @override
  List<Object?> get props => [volunteerModel];
}

class VolunteerSelectedState extends VolunteerState {}

class VolunteerErrorState extends VolunteerState {
  final String message;

  VolunteerErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class VolunteerPictureState extends VolunteerState {
  final Uint8List? imageProfile;

  VolunteerPictureState({required this.imageProfile});

  @override
  List<Object?> get props => [imageProfile];
}


class VolunteerInfoState extends VolunteerState {
  final String lastName;
  final String firstName;
  final String birthDate;
  final String phoneNumber;
  final String? address;
  final String? city;
  final String? postalCode;
  final String? bio;

  VolunteerInfoState({
    required this.lastName,
    required this.firstName,
    required this.birthDate,
    required this.phoneNumber,
    this.bio,
    this.address,
    this.city,
    this.postalCode,
  });

  @override
  List<Object?> get props => [
        lastName,
        firstName,
        birthDate,
        phoneNumber,
        bio,
        address,
        city,
        postalCode,
      ];
}

class VolunteerUpdateState extends VolunteerState {
  final String statusCode;

  VolunteerUpdateState({required this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

class VolunteerDeleteState extends VolunteerState {
  final String statusCode;

  VolunteerDeleteState({required this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

class VolunteerGetState extends VolunteerState {
  final String statusCode;

  VolunteerGetState({required this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

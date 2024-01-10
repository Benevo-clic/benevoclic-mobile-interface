import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/location_model.dart';

import '../../models/volunteer_model.dart';

@immutable
abstract class VolunteerState {
  Volunteer? volunteer;

  getVolunteer() {
    return volunteer;
  }

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

class VolunteerEditingState extends VolunteerState {}

class VolunteerUpdatingState extends VolunteerState {
  final Volunteer volunteerModel;

  VolunteerUpdatingState({required this.volunteerModel});

  @override
  List<Object?> get props => [volunteerModel];
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
  final LocationModel? location;
  final String? bio;

  VolunteerInfoState({
    required this.lastName,
    required this.firstName,
    required this.birthDate,
    required this.phoneNumber,
    this.bio,
    this.location,
  });

  @override
  List<Object?> get props => [
        lastName,
        firstName,
        birthDate,
        phoneNumber,
        bio,
        location,
      ];
}

class VolunteerInfo extends VolunteerState {
  final Volunteer volunteer;

  VolunteerInfo({required this.volunteer});

}

class VolunteerFollowAssociationState extends VolunteerState {
  final Association association;

  VolunteerFollowAssociationState({required this.association});

  @override
  List<Object?> get props => [association];
}

class VolunteerUnFollowAssociationState extends VolunteerState {
  final Association association;

  VolunteerUnFollowAssociationState({required this.association});

  @override
  List<Object?> get props => [association];
}

class VolunteerUpdateState extends VolunteerState {
  final Volunteer volunteerModel;

  VolunteerUpdateState({required this.volunteerModel});

  @override
  List<Object?> get props => [volunteerModel];
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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';

@immutable
abstract class AssociationState {}

class AssociationInitialState extends AssociationState {}

class AssociationLoadingState extends AssociationState {}

class AssociationCreatedState extends AssociationState {
  final Association associationModel;

  AssociationCreatedState({required this.associationModel});
}

class AssociationSelectedState extends AssociationState {}

class AssociationErrorState extends AssociationState {
  final String message;

  AssociationErrorState({required this.message});
}


class AssociationInfoState extends AssociationState {
  final String name;
  final String? bio;
  final String? address;
  final String phone;
  final String? city;
  final String? country;
  final String? postalCode;
  final String type;

  AssociationInfoState({
    required this.name,
    this.bio,
    this.address,
    required this.phone,
    this.city,
    this.country,
    this.postalCode,
    required this.type,
  });
}

class AssociationPictureState extends AssociationState {
  final Uint8List? imageProfile;

  AssociationPictureState({required this.imageProfile});
}

class AssociationUpdateState extends AssociationState {}

class AssociationDeleteState extends AssociationState {}

class AssociationVerifyState extends AssociationState {
  final bool isVerified;

  AssociationVerifyState({required this.isVerified});
}

class AssociationVerifyErrorState extends AssociationState {}

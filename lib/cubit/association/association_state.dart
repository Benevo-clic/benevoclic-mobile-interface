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

class AssociationPictureState extends AssociationState {}

class AssociationInfoState extends AssociationState {
  final String? name;
  final String? bio;
  final String? address;
  final String? phone;
  final String? email;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? siret;

  AssociationInfoState({
    this.name,
    this.bio,
    this.address,
    this.phone,
    this.email,
    this.city,
    this.country,
    this.postalCode,
    this.siret,
  });
}

class AssociationUpdateState extends AssociationState {}

class AssociationDeleteState extends AssociationState {}

class AssociationVerifyState extends AssociationState {}

class AssociationVerifyErrorState extends AssociationState {}

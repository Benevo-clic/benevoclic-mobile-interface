import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';

@immutable
abstract class AssociationState {
  Association? association;

  @override
  List<Object?> get props => [];
}

class AssociationInitialState extends AssociationState {}

class AssociationLoadingState extends AssociationState {}

class AssociationCreatedState extends AssociationState {
  final Association associationModel;

  AssociationCreatedState({required this.associationModel});

  @override
  List<Object?> get props => [associationModel];
}

class AssociationSelectedState extends AssociationState {}

class AssociationErrorState extends AssociationState {
  final String message;

  AssociationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AssociationInfoState extends AssociationState {
  final String name;
  final String? bio;
  final String? address;
  final String phone;
  final String? city;
  final String? postalCode;
  final String type;

  AssociationInfoState({
    required this.name,
    this.bio,
    this.address,
    required this.phone,
    this.city,
    this.postalCode,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        bio,
        address,
        phone,
        city,
        postalCode,
        type,
      ];
}

class AssociationConnexion extends AssociationState {

  AssociationConnexion(Association associationParam){
    association = associationParam;
  }
}

class AssociationPictureState extends AssociationState {
  final Uint8List? imageProfile;

  AssociationPictureState({required this.imageProfile});

  @override
  List<Object?> get props => [imageProfile];
}

class AssociationUpdateState extends AssociationState {}

class AssociationDeleteState extends AssociationState {}

class AssociationVerifyState extends AssociationState {
  final bool isVerified;

  AssociationVerifyState({required this.isVerified});

  @override
  List<Object?> get props => [isVerified];
}

class AssociationVerifyErrorState extends AssociationState {}

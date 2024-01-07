import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/location_model.dart';

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

class AssociationErrorState extends AssociationState {
  final String message;

  AssociationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AssociationInfoState extends AssociationState {
  final String name;
  final String? bio;
  final LocationModel? location;
  final String phone;
  final String type;

  AssociationInfoState({
    required this.name,
    this.bio,
    this.location,
    required this.phone,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        bio,
        location,
        phone,
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

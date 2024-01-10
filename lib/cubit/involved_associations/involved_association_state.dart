import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';

@immutable
abstract class InvolvedAssociationState {
  List<Association> associations = [];
  Association? detailAssociation;
}

class InvolvedAssociationAcceptedState extends InvolvedAssociationState {
  final List<Association> associations;

  InvolvedAssociationAcceptedState({required this.associations});
}

class InvolvedAssociationLoadingState extends InvolvedAssociationState {}

class InvolvedAssociationDetailState extends InvolvedAssociationState {
  final Association association;

  InvolvedAssociationDetailState({required this.association});
}

class InvolvedAssociationAnnouncementState extends InvolvedAssociationState {
  final Association association;

  InvolvedAssociationAnnouncementState({required this.association});
}

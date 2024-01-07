import 'dart:typed_data';

import '../../models/association_model.dart';
import '../../models/volunteer_model.dart';

abstract class SignupState {
  @override
  List<Object?> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupCreatedAssociationState extends SignupState {
  final Association associationModel;

  SignupCreatedAssociationState({required this.associationModel});

  @override
  List<Object?> get props => [associationModel];
}

class SignupCreatedVolunteerState extends SignupState {
  final Volunteer volunteerModel;

  SignupCreatedVolunteerState({required this.volunteerModel});

  @override
  List<Object?> get props => [volunteerModel];
}

class SignupErrorState extends SignupState {
  final String message;

  SignupErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignupPictureState extends SignupState {
  final Uint8List? imageProfile;

  SignupPictureState({required this.imageProfile});

  @override
  List<Object?> get props => [imageProfile];
}

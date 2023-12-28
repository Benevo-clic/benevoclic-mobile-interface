import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OtherAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtherAuthInitialState extends OtherAuthState {}

class OtherAuthErrorState extends OtherAuthState {
  final String message;

  OtherAuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtherAuthLoadedState extends OtherAuthState {
  UserCredential userCredential;

  OtherAuthLoadedState({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class GoogleAuthState extends OtherAuthState {}

class OtherAuthLoadingState extends OtherAuthState {}

class FacebookAuthState extends OtherAuthState {}

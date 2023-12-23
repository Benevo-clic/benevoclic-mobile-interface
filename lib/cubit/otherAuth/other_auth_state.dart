import 'package:firebase_auth/firebase_auth.dart';

abstract class OtherAuthState {}

class OtherAuthInitialState extends OtherAuthState {}

class OtherAuthErrorState extends OtherAuthState {
  final String message;

  OtherAuthErrorState({required this.message});
}

class OtherAuthLoadedState extends OtherAuthState {
  UserCredential userCredential;

  OtherAuthLoadedState({required this.userCredential});

}

class GoogleAuthState extends OtherAuthState {}

class OtherAuthLoadingState extends OtherAuthState {}

class FacebookAuthState extends OtherAuthState {}

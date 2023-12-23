abstract class OtherAuthState {}

class OtherAuthInitialState extends OtherAuthState {}

class OtherAuthErrorState extends OtherAuthState {
  final String message;

  OtherAuthErrorState({required this.message});
}

class OtherAuthLoadedState extends OtherAuthState {}

class GoogleAuthState extends OtherAuthState {}

class OtherAuthLoadingState extends OtherAuthState {}

class FacebookAuthState extends OtherAuthState {}

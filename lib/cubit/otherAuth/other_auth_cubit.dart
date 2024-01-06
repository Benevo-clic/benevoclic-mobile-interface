import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/google/auth_repository.dart';
import 'other_auth_state.dart';

class OtherAuthCubit extends Cubit<OtherAuthState> {
  final AuthRepository _authRepository;

  OtherAuthCubit(this._authRepository) : super(OtherAuthInitialState());

  void otherAuthError(String message) {
    emit(OtherAuthErrorState(message: message));
  }

  Future<void> googleAuth() async {
    if (state is OtherAuthLoadingState) {
      return;
    }
    emit(OtherAuthLoadingState());
    try {
      UserCredential userCredential = await _authRepository.signInWithGoogle();
      emit(OtherAuthLoadedState(userCredential: userCredential));
    } catch (e) {
      emit(OtherAuthErrorState(message: e.toString()));
    }
  }

  void facebookAuth() {
    emit(FacebookAuthState());
  }
}

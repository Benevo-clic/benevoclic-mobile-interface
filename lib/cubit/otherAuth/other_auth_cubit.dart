import 'package:bloc/bloc.dart';

import '../../../../../repositories/auth_repository.dart';
import 'other_auth_state.dart';

class OtherAuthCubit extends Cubit<OtherAuthState> {
  final AuthRepository _authRepository;

  OtherAuthCubit(this._authRepository) : super(OtherAuthInitialState());

  void otherAuth() {
    emit(OtherAuthLoadedState());
  }

  void otherAuthError(String message) {
    emit(OtherAuthErrorState(message: message));
  }

  Future<void> googleAuth() async {
    emit(OtherAuthLoadingState());
    try {
      await _authRepository.signInWithGoogle();
      emit(OtherAuthLoadedState());
    } catch (e) {
      emit(OtherAuthErrorState(message: e.toString()));
    }
  }

  void facebookAuth() {
    emit(FacebookAuthState());
  }
}

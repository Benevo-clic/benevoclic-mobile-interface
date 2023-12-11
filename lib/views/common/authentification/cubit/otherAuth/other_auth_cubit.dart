import 'package:bloc/bloc.dart';

import '../../repository/auth_repository.dart';
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

  void googleAuth() {
    emit(OtherAuthLoadingState());

    _authRepository.signInWithGoogle().then((token) {
      if (token != null) {
        emit(GoogleAuthState());
      } else {
        emit(OtherAuthErrorState(message: "Connexion annulée ou échouée."));
      }
    }).catchError((e) {
      emit(OtherAuthErrorState(message: e.toString()));
    });
  }

  void facebookAuth() {
    emit(FacebookAuthState());
  }
}

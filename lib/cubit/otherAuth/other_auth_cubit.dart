import 'package:bloc/bloc.dart';

import '../../repositories/google/auth_repository.dart';
import 'other_auth_state.dart';

class OtherAuthCubit extends Cubit<OtherAuthState> {
  final AuthRepository _authRepository;

  OtherAuthCubit(this._authRepository) : super(OtherAuthInitialState());

  void otherAuthError(String message) {
    emit(OtherAuthErrorState(message: message));
  }
}

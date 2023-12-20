import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../repositories/api/user_repository.dart';
import '../../views/common/authentification/repository/auth_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository = AuthRepository();

  UserCubit(
      {required UserRepository userRepository,
      required AuthRepository authRepository})
      : _userRepository = userRepository,
        super(UserInitialState());

  void formLogin() {
    emit(UserInitialState());
  }

  void formRegister() {
    emit(UserInitialState());
  }

  void changeState(UserState userState) {
    emit(userState);
  }

  void userRoleNotMatched() {
    emit(UserRoleNotMatched());
  }

  void userConnexion(UserModel userModel) {
    emit(UserConnexionState(userModel: userModel));
  }

  Future<void> createUser(String email, String password) async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      User userCredential =
          await _authRepository.createAccount(email, password);

      emit(UserEmailVerificationState(user: userCredential));
    } catch (e) {
      emit(UserRegisterErrorState(message: e.toString()));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      await _authRepository.sendEmailVerification();
      emit(UserEmailVerificationState());
    } catch (e) {
      emit(UserRegisterErrorState(message: e.toString()));
    }
  }

  Future<void> createUserType(
      RulesType rulesType, String email, String password) async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      await _authRepository.authAdressPassword(email, password);

      final users = await _userRepository.createUser(rulesType);

      emit(UserCreatedState(statusCode: users.toString()));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<UserModel> getUser() async {
    return await _userRepository.getUser();
  }

  Future<void> connexion() async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));

      final users = await _userRepository.connexion();
      emit(ResponseUserState(user: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> disconnect() async {
    try {
      emit(UserLoadingState());
      final users = await _userRepository.disconnect();
      emit(UserDisconnectedState(statusCode: users.toString()));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}



import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../repositories/api/user_repository.dart';
import '../../repositories/auth_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository = AuthRepository();
  UserModel? user;

  UserCubit({ this.user,
      required UserRepository userRepository,
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
    user = userModel;
    if (state is UserConnexionState) {
      return;
    }
    userModel = userModel;
    emit(UserConnexionState(userModel: userModel));
  }

  Future<void> createUser(String email, String password) async {
    if (state is UserEmailVerificationState) {
      return;
    }

    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      UserCredential userCredential =
          await _authRepository.createAccountWithEmailPassword(email, password);

      emit(UserEmailVerificationState(user: userCredential.user));
    } catch (e) {
      emit(UserRegisterErrorState(message: e.toString()));
    }
  }

  Future<void> googleAuth() async {
    if (state is UserEmailVerificationState) {
      return;
    }
    emit(UserLoadingState());
    try {
      UserCredential userCredential = await _authRepository.signInWithGoogle();
      emit(UserEmailGoggleVerificationState(user: userCredential.user));
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

  Future<void> createUserOtherConnexion(RulesType rulesType) async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      final users = await _userRepository.createUser(rulesType);
      emit(UserCreatedState(statusCode: users.toString()));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> createUserType(
      RulesType rulesType, String email, String password) async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      await _authRepository.signInWithEmailAndPassword(email, password);
      final users = await _userRepository.createUser(rulesType);

      emit(UserCreatedState(statusCode: users.toString()));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    return await _userRepository.getUserByEmail(email);
  }

  Future<void> updateUser(UserModel user) async {
    if (state is UserUpdateState) {
      return;
    }
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      final users = await _userRepository.updateUser(user);
      emit(UserUpdateState(userModel: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> connexion(userModel) async {
    if (state is ResponseUserState) {
      return;
    }
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      user = userModel;
      final users = await _userRepository.connexion();
      emit(ResponseUserState(user: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> disconnect() async {
    if (state is UserDisconnectedState) {
      return;
    }
    try {
      emit(UserLoadingState());
      final users = await _userRepository.disconnect();
      emit(UserDisconnectedState(statusCode: users.toString()));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}

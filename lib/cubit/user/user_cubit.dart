import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../repositories/api/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitialState());

  void formLogin() {
    emit(UserInitialState());
  }

  void changeState(UserState userState) {
    emit(userState);
  }

  void userConnexion(UserModel userModel) {
    emit(UserConnexionState(userModel: userModel));
  }

  Future<void> createUser(RulesType rulesType) async {
    try {
      emit(UserLoadingState());
      final users = await _userRepository.createUser(rulesType);
      emit(UserCreatedState(statusCode: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<void> connexion() async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 2));

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

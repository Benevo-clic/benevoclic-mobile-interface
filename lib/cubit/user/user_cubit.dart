


import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../repositories/api/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitialState());

  Future<void> getUser(RulesType rulesType) async {
    try {
      emit(UserLoadingState());
      final users = await _userRepository.createUser(rulesType);
      emit(ResponseUserState(statusCode: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}
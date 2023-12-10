import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/user/user_cubit.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/repositories/api/user_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login.dart';
import 'package:namer_app/views/navigation_bar.dart';

class LoginController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserCubit(userRepository: UserRepository()),
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserInitialState) {
            return LoginPage(title: RulesType.USER_ASSOCIATION);
          } else if (state is UserLoadingState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationExample()),
            );
          }
          return Scaffold();
        }));
  }
}

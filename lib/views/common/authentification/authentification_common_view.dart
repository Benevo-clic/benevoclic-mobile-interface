



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../cubit/user/user_state.dart';
import '../../../repositories/api/user_repository.dart';
import '../../../widgets/loading_widget.dart';
import '../../login.dart';
import '../../navigation_bar.dart';

class AuthentificationView extends StatelessWidget {

 const AuthentificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserCubit(userRepository: UserRepository()),
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserInitialState) {
            return LoginPage();
          } else if (state is UserLoadingState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationExample()),
            );
          }
          return Scaffold();
        }));
  }

  Widget _buildBody(BuildContext context, UserState state) {
    if(state is UserLoadingState) {
      return const LoadingWidget();
    }


    return const Center(
      child: Text("Error"),
    );
  }
}
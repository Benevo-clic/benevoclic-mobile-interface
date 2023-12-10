import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../../cubit/user/user_state.dart';
import '../../../widgets/loading_widget.dart';
import 'cubit/typeAuth/auth_type_cubit.dart';
import 'cubit/typeAuth/auth_type_state.dart';
import 'login.dart';

class AuthentificationView extends StatelessWidget {
  const AuthentificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthTypeCubit, AuthTypeState>(
      builder: (context, state) {
        if (state is AssociationLoginState) {
          return LoginPage(
            title: RulesType.USER_ASSOCIATION,
          );
        } else if (state is VolunteerLoginState) {
          return LoginPage(
            title: RulesType.USER_VOLUNTEER,
          );
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, InscriptionState state) {
    if (state is UserLoadingState) {
      return const LoadingWidget();
    }
    return const Center(
      child: Text("Error"),
    );
  }
}
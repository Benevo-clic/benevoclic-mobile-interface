import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/widgets/inscription_widget.dart';

import '../../../../cubit/user/user_cubit.dart';
import '../../../../cubit/user/user_state.dart';
import '../../../../type/rules_type.dart';

class SignupVolunteer extends StatelessWidget {
  const SignupVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserRegisterErrorState) {
        final snackBar = SnackBar(
          content: const Text(
              'Votre email est déjà utilisé, veuillez vous connecter'),
          action: SnackBarAction(
            label: 'Annuler',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      return InscriptionWidget(
          rulesType: RulesType.USER_VOLUNTEER, state: state);
    },
    );
  }
}

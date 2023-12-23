import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../cubit/otherAuth/other_auth_state.dart';
import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../cubit/user/user_state.dart';
import '../../../../../repositories/api/user_repository.dart';
import '../../../../../type/rules_type.dart';
import '../../../../associtions/navigation_association.dart';
import '../../../../associtions/signup/inscription_assocition_signup.dart';
import '../../../../volunteers/navigation_volunteer.dart';
import '../../../../volunteers/signup/infos_inscription.dart';

class OtherConnection extends StatefulWidget {
  final BuildContext context;
  final RulesType rulesType;

  const OtherConnection({required this.context, required this.rulesType});

  @override
  _OtherConnectionState createState() => _OtherConnectionState();
}

class _OtherConnectionState extends State<OtherConnection> {
  late String? _email;
  late String? _id;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<UserCubit>();
      cubit.googleAuth();
    });
  }

  @override
  Widget build(Object context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserEmailVerificationState) {
          _email = state.user!.email ?? "aaaa@gmail.com";
          _id = state.user!.uid;
          final userModel = await UserRepository().isUserExist(_email!);

          if (!userModel) {
            final cubit = context.read<UserCubit>();
            cubit.createUserOtherConnexion(widget.rulesType);
          } else if (userModel) {
            _navigateToNextPage(context, widget.rulesType);
          }
        }

        if (state is UserCreatedState) {
          if (widget.rulesType == RulesType.USER_VOLUNTEER) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfosInscriptionVolunteer(
                    email: _email!,
                    id: _id!,
                  ),
                ),
              );
            });
          } else if (widget.rulesType == RulesType.USER_ASSOCIATION) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InscriptionAssociation(
                    email: _email!,
                    id: _id!,
                  ),
                ),
              ); // Pas nécessaire de mettre cette partie dans addPostFrameCallback
            });
          }
        }
        // if (state is OtherAuthLoadedState) {
        //   final verify = await AuthRepository().verifiedEmail();
        //   print(verify);
        //   String? email = state.userCredential.user?.email ?? "";
        //   UserModel userModel = await UserRepository().getUserByEmail(email);
        //   if (userModel.isActif) {
        //     _navigateToNextPage(context, widget.rulesType);
        //   } else if (!userModel.isActif) {
        //     final cubit = context.read<UserCubit>();
        //     cubit.createUserOtherConnexion(widget.rulesType);
        //   }
        // }
      },
      builder: (context, state) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget _buildLoading(BuildContext context, OtherAuthLoadingState state) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Future<void> _navigateToNextPage(
    BuildContext context, RulesType rulesType) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  if (rulesType == RulesType.USER_ASSOCIATION) {
    preferences.setBool('Association', true);
  } else if (rulesType == RulesType.USER_VOLUNTEER) {
    preferences.setBool('Volunteer', true);
  }

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return rulesType == RulesType.USER_ASSOCIATION
        ? NavigationAssociation()
        : NavigationVolunteer();
  }));

  BlocProvider.of<UserCubit>(context).changeState(UserInitialState());
}

authFacebook() async {}

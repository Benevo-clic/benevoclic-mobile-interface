/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../cubit/user/user_state.dart';
import '../../../../../models/user_model.dart';
import '../../../../../repositories/api/user_repository.dart';
import '../../../../../repositories/auth_repository.dart';
import '../../../../../type/rules_type.dart';
import '../../../../../util/errorFirebase.dart';
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

  _submit(UserEmailGoggleVerificationState state) async {
    try {
      _email = state.user!.email ?? "aaaa@gmail.com";
      _id = state.user!.uid;
      final userModel = await UserRepository().isUserExist(_email!);

      if (!userModel) {
        final cubit = context.read<UserCubit>();
        cubit.createUserOtherConnexion(widget.rulesType);
      } else if (userModel) {
        UserModel user = await UserRepository().getUserByEmail(_email!);
        if (user.isActif && user.rule.rulesType == widget.rulesType) {
          BlocProvider.of<UserCubit>(context).connexion();
          SnackBar snackBar = SnackBar(
            content: Text("Connexion réussi"),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _navigateToNextPage(context, widget.rulesType, user.id);
        } else if (!user.isActif) {
          final cubit = context.read<UserCubit>();
          cubit.createUserOtherConnexion(widget.rulesType);
        } else if (user.isActif && user.rule.rulesType != widget.rulesType) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Vous avez déjà un compte avec un autre type de compte"),
            ),
          );
          await AuthRepository().signOut();
          Navigator.pop(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      ErrorFirebase.errorCheck(e.code, context);
    }
  }

  @override
  Widget build(Object context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserEmailGoggleVerificationState) {
          _submit(state);
        }
        if (state is UserRegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur lors de l'inscription"),
            ),
          );
          await AuthRepository().signOut();
          Navigator.pop(context);
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
              );
            });
          }
        }
      },
      builder: (context, state) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Future<void> _navigateToNextPage(BuildContext context, RulesType rulesType,
    String id) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  if (rulesType == RulesType.USER_ASSOCIATION) {
    preferences.setBool('Association', true);
    preferences.setString('idAssociation', id);
  } else if (rulesType == RulesType.USER_VOLUNTEER) {
    preferences.setBool('Volunteer', true);
    preferences.setString('idVolunteer', id);
  }

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return rulesType == RulesType.USER_ASSOCIATION
        ? NavigationAssociation()
        : NavigationVolunteer();
  }));

  BlocProvider.of<UserCubit>(context).changeState(UserInitialState());
}

authFacebook() async {}
*/
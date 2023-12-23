import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../cubit/otherAuth/other_auth_cubit.dart';
import '../../../../../cubit/otherAuth/other_auth_state.dart';
import '../../../../../cubit/user/user_cubit.dart';
import '../../../../../cubit/user/user_state.dart';
import '../../../../../type/rules_type.dart';
import '../../../../associtions/navigation_association.dart';
import '../../../../volunteers/navigation_volunteer.dart';

class OtherConnection extends StatefulWidget {
  final BuildContext context;
  final RulesType rulesType;

  const OtherConnection({required this.context, required this.rulesType});

  @override
  _OtherConnectionState createState() => _OtherConnectionState();
}

class _OtherConnectionState extends State<OtherConnection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<OtherAuthCubit>();
      cubit.googleAuth();
    });
  }

  @override
  Widget build(Object context) {
    return BlocConsumer<OtherAuthCubit, OtherAuthState>(
      listener: (context, state) async {
        if (state is OtherAuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur lors de l'inscription"),
            ),
          );
        }
        if (state is OtherAuthLoadedState) {
          _navigateToNextPage(context, widget.rulesType);
        }
      },
      builder: (context, state) {
        if (state is OtherAuthLoadingState) {
          return _buildLoading(context, state);
        }
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

Widget _buildColumnWithData(BuildContext context) {
  return Text("");
}

authFacebook() async {}

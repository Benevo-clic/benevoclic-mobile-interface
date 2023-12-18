import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/views/common/authentification/cubit/otherAuth/other_auth_cubit.dart';

import '../../../../../type/rules_type.dart';
import '../../../../navigation_bar.dart';
import '../../cubit/otherAuth/other_auth_state.dart';
import '../widgets/login.dart';

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
      },
      builder: (context, state) {
        if (state is GoogleAuthState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NavigationExample()));
          });
          return _buildColumnWithData(context);
        }

        if (state is OtherAuthLoadingState) {
          return _buildLoading(context, state);
        }
        if (state is OtherAuthErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          title: widget.rulesType,
                ),
              ),
            );
          });
          return _buildError();
        }

        return Text('Unknown state: $state');
      },
    );
  }
}

Widget _buildLoading(BuildContext context, OtherAuthLoadingState state) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildError() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildColumnWithData(BuildContext context) {
  return Text("");
}

authFacebook() async {}

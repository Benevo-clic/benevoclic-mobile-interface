import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/views/common/authentification/cubit/otherAuth/other_auth_cubit.dart';

import '../../navigation_bar.dart';
import 'cubit/otherAuth/other_auth_state.dart';

class OtherConnection extends StatefulWidget {
  final BuildContext context;

  const OtherConnection(this.context);

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
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        print("state: ");
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
          return _buildError();
        }

        return Text(
            'Unknown state: $state'); // Supposons que ceci est un widget
      },
    );
  }
}

Widget _buildInitialInput() {
  return const Center(
    child: Text('Please enter an email and password'),
  );
}

Widget _buildLoading(BuildContext context, OtherAuthLoadingState state) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildError() {
  return const Center(
    child: Text('Error'),
  );
}

Widget _buildColumnWithData(BuildContext context) {
  return Text("Connexion réussie");
}

authFacebook() async {}

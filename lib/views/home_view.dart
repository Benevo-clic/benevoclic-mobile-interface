import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/widgets/background.dart';

import 'common/authentification/cubit/typeAuth/auth_type_cubit.dart';
import 'common/authentification/login/widgets/authentification_common_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //permet de ne pas changer l'orientation du telephone
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Background(
      image: "assets/background1.png",
      widget: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Image.asset("assets/logo.png",
                      height: 150, alignment: Alignment.center),
                  SizedBox(height: 80),
                  Text("Se connecter",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 15),
                  _loginButton(context, "Association", Colors.deepOrange, () {
                    context.read<AuthTypeCubit>().loginAsAssociation();
                    print("Association");
                    _navigateToAuthentification(context);
                  }),
                  SizedBox(height: 20),
                  _loginButton(context, "Bénévole", Colors.pink.shade900, () {
                    context.read<AuthTypeCubit>().loginAsVolunteer();
                    _navigateToAuthentification(context);
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  _signupSection(),
                ],
              ),
            ),
          )),
    );
  }

  void _navigateToAuthentification(BuildContext context) {
    print("navigate to authentification");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthentificationView()));
    });
  }

  Widget _loginButton(
      BuildContext context, String title, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 277,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: Colors.black,
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  Widget _signupSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Pas de compte ?"),
        TextButton(
          onPressed: () {},
          child: Text("Inscris toi !",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black)),
        )
      ],
    );
  }
}

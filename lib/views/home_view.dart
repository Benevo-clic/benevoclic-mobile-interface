import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/views/associtions/navigation_association.dart';
import 'package:namer_app/views/volunteers/navigation_volunteer.dart';
import 'package:namer_app/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/authentification/cubit/typeAuth/auth_type_cubit.dart';
import 'common/authentification/login/widgets/authentification_common_widget.dart';

class HomeView extends StatefulWidget {
  String? title = "Je suis";

  HomeView({super.key, this.title});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool voluntter = false;
  bool association = false;
  bool isLoading = true;

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('Volunteer') != null) {
      voluntter = preferences.getBool('Volunteer')!;
    }

    if (preferences.getBool('Association') != null) {
      association = preferences.getBool('Association')!;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (voluntter) {
      return NavigationVolunteer();
    } else if (association) {
      return NavigationAssociation();
    } else {
      return Background(
        image: "assets/background1.png",
        widget: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset("assets/logo.png",
                        height: 150, alignment: Alignment.center),
                    SizedBox(height: 80),
                    Text(widget.title ?? "Je suis",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 15),
                    _loginButton(context, "Association", Colors.deepOrange, () {
                      context.read<AuthTypeCubit>().loginAsAssociation();
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _navigateToAuthentification(BuildContext context) {
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

}

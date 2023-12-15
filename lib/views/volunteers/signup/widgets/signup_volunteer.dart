import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../cubit/user/user_cubit.dart';
import '../../../../cubit/user/user_state.dart';
import '../../../../type/rules_type.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../common/authentification/login/statefullwIdgets/other_connexion.dart';
import '../signup_form.dart';

class SignupVolunteer extends StatelessWidget {
  final String title;

  const SignupVolunteer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserErrorState) {
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
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background1.png"),
                          fit: BoxFit.cover)),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthAppBar(
                        contexts: context,
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        endIndent: MediaQuery.of(context).size.height * .04,
                        indent: MediaQuery.of(context).size.height * .04,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Inscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .06,
                          color: Color.fromRGBO(235, 126, 26, 1),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Inscrivez-vous en tant que bénévole',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      SignupForm(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 25, right: 5),
                              // Ajustez selon vos besoins
                              child: Divider(
                                color: Colors.grey.shade400,
                                height: 1.5,
                              ),
                            ),
                          ),
                          Text("OU"), // Texte à afficher au milieu
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5, right: 25),
                              // Ajustez selon vos besoins
                              child: Divider(
                                color: Colors.grey.shade400,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtherConnection(
                                        context: context,
                                        rulesType: RulesType.USER_VOLUNTEER,
                                      ),
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(FontAwesomeIcons.google),
                                  // Icône Google
                                  SizedBox(width: 10),

                                  Text("Google"),
                                  // Texte
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Divider(
                              color: Colors.black,
                              height: 100,
                              indent: 12,
                              endIndent: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtherConnection(
                                          context: context,
                                          rulesType: RulesType.USER_VOLUNTEER),
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(FontAwesomeIcons.squareFacebook),
                                  SizedBox(width: 10),
                                  Text("Facebook"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                if (state is UserLoadingState) _buildLoading(context, state),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLoading(BuildContext context, UserLoadingState state) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Fond semi-transparent noir
      width: double.infinity, // Couvre toute la largeur
      height: MediaQuery.of(context).size.height, // Couvre toute la hauteur
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

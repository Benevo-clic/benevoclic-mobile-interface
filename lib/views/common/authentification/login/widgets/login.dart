import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/cubit/user/user_cubit.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../../../../widgets/auth_app_bar.dart';
import '../../../../associtions/signup/signup_association.dart';
import '../../../../volunteers/signup/widgets/signup_volunteer.dart';
import '../statefullwIdgets/formulaire_connexion.dart';
import '../statefullwIdgets/other_connexion.dart';

class LoginPage extends StatelessWidget {
  final RulesType title;

  LoginPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Nous n'avons pas pu vous connecter"),
          ),
        );
      }
    }, builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
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
                      AuthAppBar(contexts: context, isLogin: true),
                      Divider(
                        color: Colors.grey.shade400,
                        endIndent: MediaQuery.of(context).size.height * .04,
                        indent: MediaQuery.of(context).size.height * .04,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Connexion",
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
                        'Connectez-vous en tant que ${title == RulesType.USER_ASSOCIATION ? 'association' : 'bénévole'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      FormulaireLogin(
                        rulesType: title,
                      ),
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
                                        rulesType: title,
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
                                          context: context, rulesType: title),
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
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.60,
                        padding: EdgeInsets.only(),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(243, 243, 243, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(5),
                          ),
                          onPressed: () {
                            if (title == RulesType.USER_ASSOCIATION) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupAssociation(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupVolunteer(),
                                ),
                              );
                            }
                            BlocProvider.of<UserCubit>(context).formRegister();
                          },
                          child: Text("Créer un compte",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(0, 15),
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

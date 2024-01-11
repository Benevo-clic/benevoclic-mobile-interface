import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/cubit/user/user_cubit.dart';
import 'package:namer_app/cubit/user/user_state.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/statefullwIdgets/formulaire_connexion.dart';
import 'package:namer_app/views/common/authentification/login/statefullwIdgets/other_connexion.dart';

import '../../../../../util/color.dart';
import '../../../../../widgets/auth_app_bar.dart';
import '../../../../associtions/signup/signup_association.dart';
import '../../../../volunteers/signup/widgets/signup_volunteer.dart';

class LoginPage extends StatelessWidget {
  final RulesType title;
  bool? isLogin = false;

  LoginPage({super.key, required this.title, this.isLogin});

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
                      AuthAppBar(contexts: context, isLogin: isLogin),
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
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Continuer avec Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                            }
                            if (title == RulesType.USER_VOLUNTEER) {
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
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : marron,
          ),
        );
      },
    );
  }
}

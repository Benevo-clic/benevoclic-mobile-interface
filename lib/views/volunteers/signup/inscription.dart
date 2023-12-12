import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../cubit/user/user_state.dart';
import '../../../type/rules_type.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../associtions/signup/infos_inscription.dart';
import '../../common/authentification/repository/auth_repository.dart';

class InscriptionDemarche extends StatelessWidget {
  final String adress;
  final String mdp;
  final RulesType title;

  InscriptionDemarche(
      {required this.adress, required this.mdp, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
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
                      AuthAppBar(),
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
                        'Connectez-vous en tant que ${title == RulesType.USER_ASSOCIATION ? 'association' : 'bénévole'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (AuthRepository().verifiedEmail() == true) {
                            print("email verifié");
                            BlocProvider.of<UserCubit>(context)
                                .createUserType(title, adress, mdp);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfosInscription()),
                            );
                          }
                        },
                        child: Text("J'ai vérifié mon adresse"),
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

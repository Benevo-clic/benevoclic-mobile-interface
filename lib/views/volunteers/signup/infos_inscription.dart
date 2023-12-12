import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../cubit/user/user_state.dart';
import '../../../models/user_model.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';

class InfosInscription extends StatefulWidget {
  const InfosInscription({super.key});

  @override
  State<InfosInscription> createState() => _InfosInscriptionState();
}

class _InfosInscriptionState extends State<InfosInscription> {
  late String _lastName;
  late String _firstName;
  late String _phone;
  late String _birthDayDate;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState!.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = context.read<UserCubit>();
      UserModel user = await cubit.getUser();
      cubit.changeState(UserConnexionState(userModel: user));
    });
  }

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
                        'Inscrivez-vous en tant que bénévole',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      _infoVolunteer(context, state),
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
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildInitialInput() {
    return const Center(
      child: Text(''),
    );
  }

  Widget _infoVolunteer(BuildContext context, state) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.all(30),
          shadowColor: Colors.grey,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Nom",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: true,
                        onSaved: (value) {
                          _lastName = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Votre nom n'est pas valide";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Prénom",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        onSaved: (value) {
                          _firstName = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Votre prénom n'est pas valide";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Téléphone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        obscureText: true,
                        onSaved: (value) {
                          _phone = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "VOtre numéro de téléphone n'est pas valide";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: const Size(0, 15),
              ),
            ],
          ),
        ),
        if (state is UserInitialState) _buildInitialInput(),
      ],
    );
  }
}

// UserCreatedState

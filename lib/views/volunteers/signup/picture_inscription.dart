import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';

import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../models/volunteer_model.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';

class PictureInscription extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String phoneNumber;
  final String bio;
  final String address;
  final String city;
  final String zipcode;

  PictureInscription(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.phoneNumber,
      required this.bio,
      required this.address,
      required this.city,
      required this.zipcode});

  @override
  State<PictureInscription> createState() => _PictureInscriptionState();
}

class _PictureInscriptionState extends State<PictureInscription> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();

  bool _isWordCountValid(String text) {
    int wordCount =
        text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    return wordCount <= 50;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<VolunteerCubit>();
      cubit.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
        listener: (context, state) {
      if (state is VolunteerInfoState) {}

      if (state is VolunteerErrorState) {
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
                      AuthAppBar(contexts: context),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                          'Définissez votre photo de profil',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // _infoVolunteer(context, state),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () {
                            final cubit = context.read<VolunteerCubit>();
                            Volunteer volunteer = Volunteer(
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              phone: widget.phoneNumber,
                              birthDayDate: widget.birthDate,
                              imageProfile: '',
                              bio: widget.bio,
                              email: '',
                            );
                            BlocProvider.of<VolunteerCubit>(context)
                                .createVolunteer(volunteer);
                          },
                          child: Text(
                            "Ingnorer cette étape",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              color: Colors.black87,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                            "Votre nom d’utilisateur sera visible sur votre profil. Vous pourrez le modifier quand vous le souhaitez.",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .03,
                              color: Colors.black87,
                            )),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.60,
                        padding: EdgeInsets.only(),
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Continuer",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              color: Colors.black,
                            ),
                          ),
                        ),
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

  Widget _infoVolunteer(BuildContext context, state) {
    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .35,
          child: Card(
            margin: const EdgeInsets.all(5),
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
                          controller: _descriptionController,
                          hintText:
                              "Entrez une description de vous jusqu'à 50 mots (facultatif)",
                          keyboardType: TextInputType.multiline,
                          maxLine: 9,
                          obscureText: false,
                          prefixIcons: false,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value != null && !_isWordCountValid(value)) {
                              return "votre description ne doit pas dépasser 50 mots";
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
        )
      ],
    );
  }
}

// UserCreatedState

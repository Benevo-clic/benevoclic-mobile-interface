import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';

import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import 'bio_inscription.dart';

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
  DateTime currentDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    final cubit = context.read<VolunteerCubit>();
    cubit.initState();
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime lastAllowedDate =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);
    DateTime initialDate =
        lastAllowedDate.isBefore(currentDate) ? lastAllowedDate : currentDate;

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: lastAllowedDate,
    );

    if (selectedDate != null) {
      dateController.text =
          DateFormat('dd/MM/yyyy').format(selectedDate.toLocal()).split(' ')[0];
      return dateController.text;
    }
    return currentDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
        listener: (context, state) {
      if (state is VolunteerInfoState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BioInscription(
                firstName: _firstName,
                lastName: _lastName,
                birthDate: _birthDayDate,
                phoneNumber: _phone,
              ),
            ),
          ); // ici mettre la page d'inscription
        });
      }

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
                        'Renseignez vos informations personnelles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      _infoVolunteer(context, state),
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final cubit = context.read<VolunteerCubit>();
                              cubit.changeState(VolunteerInfoState(
                                birthDate: _birthDayDate,
                                firstName: _firstName,
                                lastName: _lastName,
                                phoneNumber: _phone,
                              ));
                            }
                          },
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
                        obscureText: false,
                        onSaved: (value) {
                          _lastName = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Votre nom n'est pas valide";
                          } else if (RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Le nom ne doit pas commencer par un chiffre";
                          } else if (value.length > 30) {
                            return "Le nom ne doit pas dépasser 50 caractères";
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
                        maxLine: 1,
                        onSaved: (value) {
                          _firstName = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Votre prénom n'est pas valide";
                          } else if (RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Le prénom ne doit pas commencer par un chiffre";
                          } else if (value.length > 50) {
                            return "Le prénom ne doit pas dépasser 50 caractères";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: dateController,
                        hintText: "Date de naissance",
                        icon: Icons.date_range,
                        obscureText: false,
                        maxLine: 1,
                        keyboardType: TextInputType.none,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Votre date de naissance n'est pas valide";
                          }
                          return null;
                        },
                        datepicker: () {
                          _selectDate(context).then((value) {
                            if (value == currentDate.toString()) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("vous devez au moins avoir 18 ans"),
                                ),
                              );
                            }
                            setState(() {
                              _birthDayDate = value.toString();
                            });
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Téléphone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        onSaved: (value) {
                          _phone = value.toString();
                        },
                        validator: (value) {
                          var regex = RegExp(r"^(0|\+33|0033)[1-9][0-9]{8}$");
                          if (value == null ||
                              !regex.hasMatch(value.toString())) {
                            return "Votre numéro de téléphone n'est pas valide";
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
      ],
    );
  }
}

// UserCreatedState

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';

import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import 'bio_inscription.dart';

class AddressInscription extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String phoneNumber;

  const AddressInscription(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.phoneNumber});

  @override
  State<AddressInscription> createState() => _AddressInscriptionState();
}

class _AddressInscriptionState extends State<AddressInscription> {
  String _city = "";
  String _zipCode = "";
  String _address = "";

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
                firstName: widget.firstName,
                lastName: widget.lastName,
                birthDate: widget.birthDate,
                phoneNumber: widget.phoneNumber,
                address: _address,
                city: _city,
                zipCode: _zipCode,
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
                        'Renseignez votre adresse',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      _infoVolunteer(context, state),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () {
                            final cubit = context.read<VolunteerCubit>();
                            cubit.changeState(VolunteerInfoState(
                              birthDate: widget.birthDate,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              phoneNumber: widget.phoneNumber,
                              address: _address,
                              city: _city,
                              postalCode: _zipCode,
                            ));
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
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                            "Votre adresse ne sera pas visible par les autres utilisateurs de l'application mais nous permettra de vous proposer des missions proches de chez vous",
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
                                birthDate: widget.birthDate,
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                phoneNumber: widget.phoneNumber,
                                address: _address,
                                city: _city,
                                postalCode: _zipCode,
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
                        hintText: "Address",
                        icon: Icons.location_on,
                        keyboardType: TextInputType.streetAddress,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {
                          _address = value.toString();
                        },
                        validator: (value) {
                          var regex = RegExp(
                              r"^\d+\s[a-zA-ZàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ'\- ]+$");
                          if (value == null || value.isEmpty) {
                            return "le champ ne doit pas être vide";
                          } else if (!regex.hasMatch(value)) {
                            return "Votre adresse n'est pas valide";
                          } else if (value.length > 50) {
                            return "Votre adresse ne doit pas dépasser 50 caractères";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Code postal",
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        prefixIcons: false,
                        maxLine: 1,
                        onSaved: (value) {
                          _zipCode = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "le champ ne doit pas être vide";
                          } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                            return "Votre code postal n'est pas valide";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "City",
                        keyboardType: TextInputType.text,
                        icon: Icons.location_city,
                        obscureText: false,
                        prefixIcons: true,
                        maxLine: 1,
                        onSaved: (value) {
                          _city = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "le champ ne doit pas être vide";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
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

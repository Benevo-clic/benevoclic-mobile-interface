import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/views/associtions/signup/picture_inscription.dart';

import '../../../cubit/association/association_state.dart';
import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';

class BioAssociationInscription extends StatefulWidget {
  final String nameAssociation;
  final String typeAssociation;
  final String phoneNumber;
  final String zipCode;
  final String address;
  final String city;
  final String id;
  final String email;

  const BioAssociationInscription(
      {super.key,
      required this.zipCode,
      required this.address,
      required this.city,
      required this.nameAssociation,
      required this.typeAssociation,
      required this.phoneNumber, required this.id, required this.email});

  @override
  State<BioAssociationInscription> createState() =>
      _BioAssociationInscriptionState();
}

class _BioAssociationInscriptionState extends State<BioAssociationInscription> {
  late String _bio = "";
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
    return BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
      if (state is AssociationInfoState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PictureInscription(
                phoneNumber: widget.phoneNumber,
                zipcode: widget.zipCode,
                address: widget.address,
                city: widget.city,
                bio: _bio,
                nameAssociation: widget.nameAssociation,
                typeAssociation: widget.typeAssociation,
                id: widget.id,
                email: widget.email,
              ),
            ),
          ); // ici mettre la page d'inscription
        });
      }

      if (state is VolunteerErrorState) {
        final snackBar = SnackBar(
          content: const Text(
              'Une erreur est survenue lors de la création de votre compte, veuillez réessayer ultérieurement'),
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
                          'Décrivez-vous en quelques mots pour que les autres utilisateurs puissent vous connaître',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      _infoAssociation(context, state),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          onPressed: () {
                            final cubit = context.read<AssociationCubit>();
                            cubit.changeState(
                              AssociationInfoState(
                                name: widget.nameAssociation,
                                type: widget.typeAssociation,
                                phone: widget.phoneNumber,
                                address: widget.address,
                                city: widget.city,
                                postalCode: widget.zipCode,
                                bio: "",
                              ),
                            );
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final cubit = context.read<AssociationCubit>();
                              cubit.changeState(
                                AssociationInfoState(
                                  name: widget.nameAssociation,
                                  type: widget.typeAssociation,
                                  phone: widget.phoneNumber,
                                  address: widget.address,
                                  city: widget.city,
                                  postalCode: widget.zipCode,
                                  bio: _bio,
                                ),
                              );
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

  Widget _infoAssociation(BuildContext context, state) {
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
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
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
                          maxLine:
                              MediaQuery.of(context).size.height * 0.44 ~/ 50,
                          obscureText: false,
                          prefixIcons: false,
                          onSaved: (value) {
                            _descriptionController.text = value.toString();
                            setState(() {
                              _bio = _descriptionController.text;
                            });
                          },
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

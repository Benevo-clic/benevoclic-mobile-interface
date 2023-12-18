import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/views/associtions/signup/address_association_inscription.dart';

import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';

class InscriptionAssociation extends StatefulWidget {
  final String id;
  final String email;

  const InscriptionAssociation(
      {super.key, required this.id, required this.email});

  @override
  State<InscriptionAssociation> createState() => _InscriptionAssociationState();
}

class _InscriptionAssociationState extends State<InscriptionAssociation> {
  late String _nameAssociation;
  late String _typeAssociation;
  late String _phone;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final cubit = context.read<AssociationCubit>();
    cubit.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
          if (state is AssociationInfoState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddressAssociationInscription(
                      nameAssociation: state.name,
                      typeAssociation: state.type,
                      phoneNumber: state.phone,
                      id: widget.id,
                      email: widget.email,
                    ),
              ),
            );
          }
          if (state is AssociationErrorState) {}
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
                        endIndent: MediaQuery
                            .of(context)
                            .size
                            .height * .04,
                        indent: MediaQuery
                            .of(context)
                            .size
                            .height * .04,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Inscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .width * .06,
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
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .width * .04,
                          color: Colors.black87,
                        ),
                      ),
                      _infoAssociation(context, state),
                      Container(
                        width: MediaQuery
                            .sizeOf(context)
                            .width * 0.8,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                            "Vos informations personnelles seront visibles que par les bénévoles",
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .03,
                              color: Colors.black87,
                            )),
                      ),
                      Container(
                        width: MediaQuery
                            .sizeOf(context)
                            .width * 0.60,
                        padding: EdgeInsets.only(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final cubit = context.read<AssociationCubit>();
                              cubit.changeState(AssociationInfoState(
                                name: _nameAssociation,
                                phone: _phone,
                                type: _typeAssociation,
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
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .04,
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
                        hintText: "Nom de l'association",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {
                          _nameAssociation = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le nom de votre association n'est pas valide";
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
                        hintText: "Type d'association",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        maxLine: 1,
                        onSaved: (value) {
                          _typeAssociation = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le type d'association n'est pas valide";
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
                        hintText: "Téléphone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        prefixIcons: true,
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

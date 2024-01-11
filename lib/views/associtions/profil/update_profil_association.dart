import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/widgets/app_bar_back.dart';

import '../../../models/location_model.dart';
import '../../../type/rules_type.dart';
import '../../../util/color.dart';
import '../../../widgets/updating_profil_picture.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import '../../common/authentification/signup/bio.dart';
import '../../common/authentification/signup/info_address.dart';
import '../navigation_association.dart';

class UpdateProfileAssociation extends StatefulWidget {
  final Association association;

  UpdateProfileAssociation({super.key, required this.association});

  @override
  State<UpdateProfileAssociation> createState() =>
      _UpdateProfileAssociationState();
}

class _UpdateProfileAssociationState extends State<UpdateProfileAssociation> {
  Uint8List? image;
  late String _bio = "";
  late LocationModel location;

  late TextEditingController _nameAssociation = TextEditingController();
  late TextEditingController _typeAssociation = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _nameAssociation.dispose();
    _typeAssociation.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameAssociation.text = widget.association.name;
    _typeAssociation.text = widget.association.type;
    _phone.text = widget.association.phone;
    _bio = widget.association.bio!;
    location = widget.association.location!;
  }

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleBioChanges(String? bio) async {
    setState(() {
      _bio = bio!;
    });
  }

  void _handleAddressFocusChanges(LocationModel? locationModel) async {
    setState(() {
      location = locationModel!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarBackWidget(),
      ),
      body: BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
          if (state is AssociationPictureState) {
            image = state.imageProfile;
            widget.association.imageProfile = base64Encode(image!);
            BlocProvider.of<AssociationCubit>(context).changeState(
                AssociationUpdatingState(associationModel: widget.association));
          }
          if (state is AssociationEditingState) {}
        },
        builder: (context, state) {
          if (state is AssociationLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AssociationUpdatingState) {
            if (state.associationModel.imageProfile != null) {
              image = base64Decode(state.associationModel.imageProfile!);
            }
            return _buildWidgetUpdate(context, widget.association);
          }
          return SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : marron,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildWidgetUpdate(BuildContext context, Association association) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            // Changez ici à min pour que la colonne prenne seulement l'espace nécessaire
            children: [
              SizedBox(height: 20),
              Center(
                child: UpdatingProfilPicture(
                  image: image,
                  rulesType: RulesType.USER_ASSOCIATION,
                ),
              ),
              _infoAssociation(context),
              BioSignup(
                onBioChanged: _handleBioChanges,
                bio: association.bio,
                isEditing: true,
              ),
              InfoAddress(
                handleAddressFocusChange: _handleAddressFocusChanges,
                address: association.location!.address,
              ),
              SizedBox(height: 80),
              // Ajoutez un espace supplémentaire pour le bouton
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: marron,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Association associationUpdate = Association(
                      name: _nameAssociation.text,
                      phone: _phone.text,
                      location: location,
                      bio: _bio,
                      email: association.email,
                      imageProfile: base64Encode(image!),
                      type: _typeAssociation.text);

                  BlocProvider.of<AssociationCubit>(context)
                      .updateAssociation(associationUpdate);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationAssociation()));
                } else {
                  print("erreur");
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // Utilisez min pour que la Row prenne seulement l'espace nécessaire
                children: [
                  Icon(Icons.check, color: Colors.white),
                  // Icône de votre choix
                  SizedBox(width: 8),
                  // Espace entre l'icône et le texte
                  Text("Modifier", // Texte du bouton
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoAssociation(BuildContext context) {
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
                        controller: _nameAssociation,
                        hintText: "Nom de l'association",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {},
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
                        controller: _typeAssociation,
                        hintText: "Type d'association",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        maxLine: 1,
                        onSaved: (value) {},
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
                        controller: _phone,
                        hintText: "Téléphone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {},
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
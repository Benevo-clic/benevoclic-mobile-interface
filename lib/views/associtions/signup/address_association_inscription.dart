import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/models/location_model.dart';

import '../../../cubit/association/association_state.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/location_form_autocomplete_widget.dart';
import 'bio_association_inscription.dart';

class AddressAssociationInscription extends StatefulWidget {
  final String nameAssociation;
  final String typeAssociation;
  final String phoneNumber;
  final String id;
  final String email;

  const AddressAssociationInscription({
    super.key,
    required this.nameAssociation,
    required this.typeAssociation,
    required this.phoneNumber,
    required this.id,
    required this.email,
  });

  @override
  State<AddressAssociationInscription> createState() =>
      _AddressAssociationInscriptionState();
}

class _AddressAssociationInscriptionState
    extends State<AddressAssociationInscription> {
  String _city = "";
  String _zipCode = "";
  late LocationModel location;
  final FocusNode _addressFocusNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _addressFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initUser();
    location = LocationModel(
      address: "",
      latitude: 0,
      longitude: 0,
    );
    _addressFocusNode.addListener(_handleAddressFocusChange);
  }

  void _initUser() async {
    final cubit = context.read<AssociationCubit>();
    cubit.initState();
  }

  void _handleAddressFocusChange() async {
    if (_addressFocusNode.hasFocus) {
      LocationModel? selectedLocation = await ShowInputAutocomplete(context);
      setState(() {
        if (selectedLocation != null) {
          location = LocationModel(
            address: selectedLocation.address,
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
          );
          _addressController.text = selectedLocation.address;
        }
      });
    }
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
              builder: (context) => BioAssociationInscription(
                nameAssociation: widget.nameAssociation,
                typeAssociation: widget.typeAssociation,
                phoneNumber: widget.phoneNumber,
                location: location,
                city: _city,
                zipCode: _zipCode,
                id: widget.id,
                email: widget.email,
              ),
            ),
          );
        });
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
                      _infoAssociation(context, state),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: TextButton(
                      //     onPressed: () {
                      //       final cubit = context.read<AssociationCubit>();
                      //       cubit.changeState(AssociationInfoState(
                      //         name: widget.nameAssociation,
                      //         type: widget.typeAssociation,
                      //         phone: widget.phoneNumber,
                      //       ));
                      //     },
                      //     child: Text(
                      //       "Ingnorer cette étape",
                      //       style: TextStyle(
                      //         fontSize: MediaQuery.of(context).size.width * .04,
                      //         color: Colors.black87,
                      //         decoration: TextDecoration.underline,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                            if (_formKey.currentState!.validate() &&
                                location.address != "") {
                              _formKey.currentState!.save();
                              final cubit = context.read<AssociationCubit>();
                              cubit.changeState(AssociationInfoState(
                                name: widget.nameAssociation,
                                type: widget.typeAssociation,
                                phone: widget.phoneNumber,
                                location: location,
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
                      _buildAddressField() ?? Container(),
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

  Widget _buildAddressField() {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      child: TextFormField(
        focusNode: _addressFocusNode,
        controller: _addressController,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          prefixIcon: Icon(
            Icons.location_on,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Votre adresse",
          hintStyle: TextStyle(color: Colors.black54),
          errorStyle: TextStyle(
            color: Colors.red[300],
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

// UserCreatedState

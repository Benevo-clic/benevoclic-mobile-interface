import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/views/common/authentification/signup/info_address.dart';

import '../../../cubit/association/association_state.dart';
import '../../../widgets/auth_app_bar.dart';
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
  late LocationModel location;



  @override
  void initState() {
    super.initState();
    _initUser();
    location = LocationModel(
      address: "",
      latitude: 0,
      longitude: 0,
    );
  }

  void _initUser() async {
    final cubit = context.read<AssociationCubit>();
    cubit.initState();
  }

  void _handleAddressFocusChanges(LocationModel? locationModel) async {
    setState(() {
      location = locationModel!;
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
              builder: (context) => BioAssociationInscription(
                nameAssociation: widget.nameAssociation,
                typeAssociation: widget.typeAssociation,
                phoneNumber: widget.phoneNumber,
                location: location,
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
                      SizedBox(
                        height: 10,
                      ),
                      InfoAddress(
                        handleAddressFocusChange: _handleAddressFocusChanges,
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
                            if (location.address != "") {
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

}

// UserCreatedState

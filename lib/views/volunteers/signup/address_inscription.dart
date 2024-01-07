import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/location_model.dart';

import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../common/authentification/signup/info_address.dart';
import 'bio_inscription.dart';

class AddressInscription extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String phoneNumber;
  final String id;
  final String email;

  const AddressInscription(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.phoneNumber,
      required this.id,
      required this.email});

  @override
  State<AddressInscription> createState() => _AddressInscriptionState();
}

class _AddressInscriptionState extends State<AddressInscription> {
  String _city = "";
  String _zipCode = "";
  late LocationModel location;

  DateTime currentDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  final FocusNode _addressFocusNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();

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
  }

  void _initUser() async {
    final cubit = context.read<VolunteerCubit>();
    cubit.initState();
  }

  void _handleAddressFocusChanges(LocationModel? locationModel) async {
    setState(() {
      location = locationModel!;
    });
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
                location: location,
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
                            print(location.address);
                            if (location.address != "") {
                              final cubit = context.read<VolunteerCubit>();
                              cubit.changeState(VolunteerInfoState(
                                birthDate: widget.birthDate,
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                phoneNumber: widget.phoneNumber,
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

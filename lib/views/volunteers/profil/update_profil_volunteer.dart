import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/models/volunteer_model.dart';

import '../../../type/rules_type.dart';
import '../../../util/color.dart';
import '../../../widgets/app_bar_back.dart';
import '../../../widgets/updating_profil_picture.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import '../../common/authentification/signup/bio.dart';
import '../../common/authentification/signup/info_address.dart';
import '../navigation_volunteer.dart';

class UpdateProfileVolunteer extends StatefulWidget {
  final Volunteer volunteer;

  UpdateProfileVolunteer({required this.volunteer});

  @override
  State<UpdateProfileVolunteer> createState() => _UpdateProfileVolunteerState();
}

class _UpdateProfileVolunteerState extends State<UpdateProfileVolunteer> {
  String _bio = "";
  late LocationModel location;
  Uint8List? image;
  DateTime currentDate = DateTime.now();
  late String _birthDayDate = "";

  TextEditingController dateController = TextEditingController();

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstName = TextEditingController();

  @override
  void dispose() {
    _lastName.dispose();
    _firstName.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.volunteer.imageProfile != null) {
      image = base64Decode(widget.volunteer.imageProfile!);
    } else {
      image = null;
    }
    _phone.text = widget.volunteer.phone;
    _bio = widget.volunteer.bio!;
    location = widget.volunteer.location!;
    _lastName.text = widget.volunteer.lastName;
    _firstName.text = widget.volunteer.firstName;
    dateController.text = widget.volunteer.birthDayDate;
  }

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarBackWidget(),
      ),
      body: BlocConsumer<VolunteerCubit, VolunteerState>(
        listener: (context, state) {
          if (state is VolunteerPictureState) {
            image = state.imageProfile;
            widget.volunteer.imageProfile = base64Encode(image!);
            BlocProvider.of<VolunteerCubit>(context).changeState(
                VolunteerUpdatingState(volunteerModel: widget.volunteer));
          }
          if (state is VolunteerEditingState) {}
        },
        builder: (context, state) {
          if (state is VolunteerLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is VolunteerUpdatingState) {
            if (state.volunteerModel.imageProfile != null) {
              image = base64Decode(state.volunteerModel.imageProfile!);
            }
            return _buildWidgetUpdate(context, state.volunteerModel);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildWidgetUpdate(BuildContext context, Volunteer volunteer) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: UpdatingProfilPicture(
                  image: image,
                  rulesType: RulesType.USER_VOLUNTEER,
                ),
              ),
              _infoVolunteer(context),
              InfoAddress(
                handleAddressFocusChange: _handleAddressFocusChanges,
                address: volunteer.location!.address,
              ),
              BioSignup(
                onBioChanged: _handleBioChanges,
                bio: volunteer.bio,
                isEditing: true,
              ),
              SizedBox(
                height: 20,
              )
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
                  Volunteer volunteerUpdate = Volunteer(
                    id: volunteer.id,
                    firstName: _firstName.text,
                    lastName: _lastName.text,
                    phone: _phone.text,
                    bio: _bio,
                    location: location,
                    birthDayDate: dateController.text,
                    imageProfile: base64Encode(image!),
                  );

                  BlocProvider.of<VolunteerCubit>(context)
                      .updateVolunteer(volunteerUpdate);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationVolunteer()));
                } else {
                  print("erreur");
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Modifier",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoVolunteer(BuildContext context) {
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
                      CustomTextFormField(
                        controller: _lastName,
                        hintText: "Nom",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {},
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
                        controller: _firstName,
                        hintText: "Prénom",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        maxLine: 1,
                        onSaved: (value) {},
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
                        prefixIcons: true,
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

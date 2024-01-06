import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class InformationDialog extends StatefulWidget {
  const InformationDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InformationDialog();
  }
}

class _InformationDialog extends State<InformationDialog> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = "";
  String _lastName = "";
  String _address = "";
  String _phone = "";
  String _birth = "";

  changeFirstName(value) {
    setState(() {
      _firstName = value;
    });
  }

  changeLastName(value) {
    setState(() {
      _lastName = value;
    });
  }

  changeAddress(value) {
    setState(() {
      _address = value;
    });
  }

  changePhone(value) {
    setState(() {
      _phone = value;
    });
  }

  changeBirthDate(value) {
    setState(() {
      _birth = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            TitleWithIcon(
                title: "Informations personnelles",
                icon: Icon(Icons.perm_identity)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  InputField(
                      title: state.volunteer!.lastName, fct: changeLastName),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(
                      title: state.volunteer!.firstName, fct: changeFirstName),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(
                      title: state.volunteer!.birthDayDate,
                      fct: changeBirthDate),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: state.volunteer!.phone, fct: changePhone),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(
                      title: "${state.volunteer!.location?.address}", fct: changeAddress),
                  SizedBox(
                    height: 10,
                  ),
                  Button(
                      text: "Sauvegarder",
                      color: Colors.black,
                      fct: () {
                        if (_formKey.currentState!.validate()) {
                          print(_firstName);
                          print(_lastName);
                          print(_phone);
                          print(_address);
                          Volunteer volunteer = Volunteer(
                              firstName: _firstName,
                              lastName: _lastName,
                              phone: _phone,
                              birthDayDate: _birth,
                              location: state.volunteer!.location,
                              bio: state.volunteer!.bio,
                              city: state.volunteer!.city,
                              email: state.volunteer!.email,
                              imageProfile: state.volunteer!.imageProfile,
                              myAssociations: state.volunteer!.myAssociations,
                              postalCode: state.volunteer!.postalCode,
                              myAssociationsWaiting:
                                  state.volunteer!.myAssociationsWaiting);
                          BlocProvider.of<VolunteerCubit>(context)
                              .updateVolunteer(volunteer);
                          BlocProvider.of<VolunteerCubit>(context)
                              .volunteerState(volunteer);
                          Navigator.pop(context);
                        }
                      },
                      backgroundColor: Colors.grey)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class InputField extends StatelessWidget {
  final String title;
  final dynamic fct;

  InputField({super.key, required this.title, required this.fct});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: title,
      onSaved: (value) {},
      validator: (value) {
        fct(value.toString());
        return null;
      },
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class PhoneDialog extends StatefulWidget {
  const PhoneDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<PhoneDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            TitleWithIcon(
                title: "Numéro de téléphone",
                icon: Icon(Icons.phone_android_sharp)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    initialValue: state.volunteer!.phone,
                    validator: (value) {
                      var phone = PhoneVerification(value.toString());
                      if (phone.security()) {
                        setState(() {
                          _phone = value;
                        });
                        return null;
                      } else {
                        return phone.message;
                      }
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Numéro de téléphone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Button(
                      text: "Sauvegarder",
                      color: Colors.black,
                      fct: () {
                        if (_formKey.currentState!.validate()) {
                          print(_phone);
                          Volunteer volunteer = Volunteer(
                              firstName: state.volunteer!.firstName,
                              lastName: state.volunteer!.lastName,
                              phone: _phone.toString(),
                              birthDayDate: state.volunteer!.birthDayDate);
                          BlocProvider.of<VolunteerCubit>(context)
                              .updateVolunteer(volunteer);
                        }
                        Navigator.pop(context);
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

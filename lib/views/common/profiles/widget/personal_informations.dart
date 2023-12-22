import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
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
                  InputField(title: "${state.volunteer!.lastName}"),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: "${state.volunteer!.firstName}"),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: "${state.volunteer!.birthDayDate}"),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: "${state.volunteer!.phone}"),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: "${state.volunteer!.address}"),
                  SizedBox(
                    height: 10,
                  ),
                  Button(
                      text: "Sauvegarder",
                      color: Colors.black,
                      fct: () {
                        if (_formKey.currentState!.validate()) {
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

  const InputField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: title,
      validator: (value) {},
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}

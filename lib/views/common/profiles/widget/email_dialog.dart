import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class EmailDialog extends StatefulWidget {
  const EmailDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<EmailDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserModel? user;
  Volunteer? volunteer;
  String? email;
  late String? _email;

  getEmail() async {
    User user = FirebaseAuth.instance.currentUser!;
    email = user.email!;
    //volunteer = await context.read<VolunteerCubit>().getVolunteer(user.email!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        getEmail();
        return Column(
          children: [
            TitleWithIcon(title: "E-mail", icon: Icon(Icons.mail)),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    initialValue: email,
                    onSaved: (value) {
                      _email = value.toString();
                    },
                    validator: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "E-mail : ${volunteer?.email}",
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
                      fct: () async {
                        print(_email);
                        volunteer?.email = _email;
                        print(volunteer?.email!);
                        //await context.read<VolunteerCubit>().updateVolunteer(volunteer!);
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

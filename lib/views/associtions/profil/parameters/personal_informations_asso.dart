import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class InformationDialogAsso extends StatefulWidget {
  const InformationDialogAsso({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InformationDialog();
  }
}

class _InformationDialog extends State<InformationDialogAsso> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _address = "";
  String _phone = "";

  changeName(value) {
    setState(() {
      _name = value;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
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
                  InputField(title: state.association!.name, fct: changeName),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(title: state.association!.phone, fct: changePhone),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(
                      title: "${state.association!.address}",
                      fct: changeAddress),
                  SizedBox(
                    height: 10,
                  ),
                  Button(
                      text: "Sauvegarder",
                      color: Colors.black,
                      fct: () {
                        if (_formKey.currentState!.validate()) {
                          print(_name);
                          print(_phone);
                          print(_address);
                          Association association = Association(
                              name: _name,
                              phone: _phone,
                              type: '',
                              address: _address,
                              bio: state.association!.bio,
                              announcement: state.association!.announcement,
                              city: state.association!.city,
                              email: state.association!.email,
                              imageProfile: state.association!.imageProfile,
                              postalCode: state.association!.postalCode,
                              verified: state.association!.verified,
                              volunteers: state.association!.volunteers,
                              volunteersWaiting:
                                  state.association!.volunteersWaiting);
                          BlocProvider.of<AssociationCubit>(context)
                              .updateAssociation(association);
                          BlocProvider.of<AssociationCubit>(context)
                              .stateInfo(association);
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

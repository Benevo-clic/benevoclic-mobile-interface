import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/views/common/profiles/widget/phone_number.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class PhoneDialogAsso extends StatefulWidget {
  const PhoneDialogAsso({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<PhoneDialogAsso> {
  final _formKey = GlobalKey<FormState>();

  String? _phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
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
                    initialValue: state.association!.phone,
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
                          Association association = Association(
                              name: state.association!.name,
                              phone: _phone.toString(),
                              type: '',
                              address: state.association!.address,
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

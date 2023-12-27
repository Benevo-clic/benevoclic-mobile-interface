import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfilAsso extends StatelessWidget {
  final Association association;

  const ModifProfilAsso({super.key, required this.association});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white, size: 45),
            backgroundColor: orange,
            actions: []),
        body: listview(context, association));
  }
}

listview(BuildContext context, Association association) {
  String email = "";
  String bio = "";
  String phone = "";
  String address = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return ListView(padding: EdgeInsets.all(25), children: [
    Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            AbstractContainer2(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Biographie",
                      icon: Icon(Icons.account_box_rounded)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.bio,
                    onSaved: (value) {
                      bio = value.toString();
                    },
                    validator: (value) {
                      bio = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${association.bio}",
                        border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            AbstractContainer2(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Informations", icon: Icon(Icons.location_city)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.address,
                    onSaved: (value) {
                      address = value.toString();
                    },
                    validator: (value) {
                      address = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: association.address,
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.email,
                    onSaved: (value) {
                      email = value.toString();
                    },
                    validator: (value) {
                      email = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${association.email}",
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.phone,
                    onSaved: (value) {
                      phone = value.toString();
                    },
                    validator: (value) {
                      phone = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: association.phone,
                        border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
          ],
        )),
    Divider(
      height: 25,
      color: Colors.white,
    ),
    ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            print(email);
            print(bio);
            print(phone);
            print(address);
            Association associationUpdate = Association(
                name: association.name,
                phone: phone,
                address: address,
                bio: bio,
                city: association.city,
                email: association.email,
                imageProfile: association.imageProfile,
                postalCode: association.postalCode,
                type: '');

            BlocProvider.of<AssociationCubit>(context)
                .updateAssociation(associationUpdate);
            BlocProvider.of<AssociationCubit>(context)
                .stateInfo(associationUpdate);

            Navigator.pop(context);
          } else {
            print("erreur");
          }
        },
        child: Text("Modifier"))
  ]);
}

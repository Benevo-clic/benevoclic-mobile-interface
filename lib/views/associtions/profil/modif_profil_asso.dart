import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/image_picker_profile.dart';
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
  String _email = "";
  String _bio = "";
  String _phone = "";
  String _address = "";

  final _formKey = GlobalKey<FormState>();
  return ListView(padding: EdgeInsets.all(25), children: [
    Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .35,
                  child: Card(
                    margin: const EdgeInsets.all(5),
                    shadowColor: Colors.grey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side:
                            BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: MyImagePicker(rulesType: RulesType.USER_VOLUNTEER),
                    ),
                  ),
                )
              ],
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
                      _bio = value.toString();
                    },
                    validator: (value) {
                      _bio = value.toString();
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
                      _address = value.toString();
                    },
                    validator: (value) {
                      _address = value.toString();
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
                      _email = value.toString();
                    },
                    validator: (value) {
                      _email = value.toString();
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
                      _phone = value.toString();
                    },
                    validator: (value) {
                      _phone = value.toString();
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
          if (_formKey.currentState!.validate()) {
            print(_email);
            print(_bio);
            print(_phone);
            print(_address);
            Association volunteerUpdate = Association(
                name: association.name,
                phone: association.phone,
                address: _address,
                bio: _bio,
                city: association.city,
                email: association.email,
                imageProfile: association.imageProfile,
                postalCode: association.postalCode,
                type: '');

            /*BlocProvider.of<A>(context)
                              .updateVolunteer(volunteerUpdate);
                          BlocProvider.of<VolunteerCubit>(context)
                              .volunteerState(volunteerUpdate);   
                          Navigator.pop(context);*/
          } else {
            print("erreur");
          }
        },
        child: Text("Modifier"))
  ]);
}

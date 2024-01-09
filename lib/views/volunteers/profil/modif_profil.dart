import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:namer_app/widgets/image_picker_profile.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white, size: 45),
            backgroundColor: orange,
            actions: []),
        body: BlocConsumer<VolunteerCubit, VolunteerState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is VolunteerInfo) {
              Volunteer volunteer = state.volunteer;
              return listview(context, volunteer);
            } else {
              return listview(
                  context,
                  Volunteer(
                      firstName: "firstName",
                      lastName: "lastName",
                      phone: "phone",
                      birthDayDate: "birthDayDate"));
            }
          },
        ));
  }
}

listview(BuildContext context, Volunteer volunteer) {

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
                      child: MyImagePicker(),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            ContentWidget(
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
                    initialValue: volunteer.bio,
                    onSaved: (value) {
                      _bio = value.toString();
                    },
                    validator: (value) {
                      _bio = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${volunteer.bio}",
                        border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            ContentWidget(
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
                    initialValue: volunteer.location!.address,
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
                        hintText: volunteer.location!.address,
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.email,
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
                        hintText: "${volunteer.email}",
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.phone,
                    onSaved: (value) {
                      _phone = value.toString();
                    },
                    validator: (value) {
                      var phoneParam = PhoneVerification(value.toString());
                      if (phoneParam.security()) {
                        _phone = value.toString();
                        return null;
                      } else {
                        return phoneParam.message;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: volunteer.phone,
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
            Volunteer volunteerUpdate = Volunteer(
                firstName: volunteer.firstName,
                lastName: volunteer.lastName,
                phone: _phone,
                birthDayDate: volunteer.birthDayDate,
                location: volunteer.location,
                bio: _bio,
                city: volunteer.city,
                email: volunteer.email,
                imageProfile: volunteer.imageProfile,
                postalCode: volunteer.postalCode);
            BlocProvider.of<VolunteerCubit>(context)
                .volunteerState(volunteerUpdate);
            BlocProvider.of<VolunteerCubit>(context)
                .updateVolunteer(volunteerUpdate);

            Navigator.pop(context);
          } else {
            print("erreur");
          }
        },
        child: Text("Modifier"))
  ]);
}

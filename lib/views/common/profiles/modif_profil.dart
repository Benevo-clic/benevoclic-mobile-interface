import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: orange,
        ),
        body: BlocConsumer<VolunteerCubit, VolunteerState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            if (state is VolunteerInfo) {
              Volunteer volunteer = state.getInfo();
              return listview(context, volunteer);
            }else{
              return Text("");
            }
          },
        ));
  }
}

class Section extends StatelessWidget {
  final String text;
  final Icon icon;

  Section({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: orange))),
        child: Row(
          children: [
            Expanded(flex: 0, child: icon),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
            ),
          ],
        ));
  }
}

listview(BuildContext context, Volunteer volunteer) {


  return ListView(
    padding: EdgeInsets.all(25),
    children: [
      AbstractContainer2(
        content: Column(
          children: [
            TitleWithIcon(title: "Photo de profil", icon: Icon(Icons.photo)),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.photo_camera,
              size: MediaQuery.sizeOf(context).width * 0.75,
            )
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
                title: "Biographie",
                icon: Icon(Icons.settings_accessibility_outlined)),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            Text(
                volunteer.bio!)
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
            Section(
                text: volunteer.firstName,
                icon: Icon(Icons.location_on_outlined)),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            Section(text: volunteer.birthDayDate, icon: Icon(Icons.mail)),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            Section(text: volunteer.phone, icon: Icon(Icons.phone_android)),
          ],
        ),
      ),
    ],
  );
}

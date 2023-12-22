import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: orange,
        ),
        body: BlocConsumer<VolunteerCubit, VolunteerState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is VolunteerInfo) {
              Volunteer volunteer = state.getInfo();
              return listview(context, volunteer);
            } else {
              return Text("");
            }
          },
        ));
  }
}

listview(BuildContext context, Volunteer volunteer) {
  String? _bio;
  return ListView(padding: EdgeInsets.all(25), children: [
    Form(
        child: Column(
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
                  title: "Biographie", icon: Icon(Icons.account_box_rounded)),
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
                  _bio = value;
                },
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "${volunteer?.bio}",
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
                initialValue: volunteer.lastName,
                onSaved: (value) {
                  _bio = value.toString();
                },
                validator: (value) {
                  _bio = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "${volunteer?.bio}",
                    border: UnderlineInputBorder()),
              ),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              TextFormField(
                initialValue: volunteer.email,
                onSaved: (value) {
                  _bio = value.toString();
                },
                validator: (value) {
                  _bio = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "${volunteer?.bio}",
                    border: UnderlineInputBorder()),
              ),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              TextFormField(
                initialValue: volunteer.phone,
                onSaved: (value) {
                  _bio = value.toString();
                },
                validator: (value) {
                  _bio = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "${volunteer?.phone}",
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
    Button(
      backgroundColor: marron,
      color: Colors.white,
      fct: () {},
      text: "Modifier",
    ),
  ]);
}

class InputTextWithIcon extends StatelessWidget {
  final String bio;

  const InputTextWithIcon({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer2(
      content: Row(children: [
        Icon(Icons.abc),
        SizedBox(
          width: 25,
        ),
        Flexible(
          child: TextFormField(
            initialValue: bio,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: bio,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
        )
      ]),
    );
  }
}

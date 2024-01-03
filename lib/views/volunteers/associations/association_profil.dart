import 'package:flutter/material.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class AssociationProfil extends StatelessWidget {
  final String bio;

  const AssociationProfil({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBarBackWidget(),
        Icon(
          Icons.pie_chart_outline_sharp,
          size: MediaQuery.sizeOf(context).height * 0.2,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        AbstractContainer2(content: Text(bio)),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
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
              Section(text: "address", icon: Icon(Icons.location_on_outlined)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: "email", icon: Icon(Icons.mail)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: "volunteer", icon: Icon(Icons.phone_android)),
            ],
          ),
        ),
      ]),
    );
  }
}

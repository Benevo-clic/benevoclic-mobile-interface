import 'package:flutter/material.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/container3.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class AssociationProfil extends StatelessWidget {
  Association association;

  AssociationProfil({super.key, required this.association});

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
        Container3(
            content: Column(
          children: [
            Row(
              children: [
                Text(association.name),
                Expanded(child: Text("")),
                Text(
                    association.volunteers?.length.toString() ?? "0 bénévoles"),
              ],
            ),
            Row(
              children: [
                Button(
                    text: "Adhérer",
                    color: Colors.white,
                    fct: () {},
                    backgroundColor: Colors.green),
                Expanded(child: Text("")),
                Button(
                    text: "Nous contacter",
                    color: Colors.white,
                    fct: () {},
                    backgroundColor: orange)
              ],
            )
          ],
        )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        AbstractContainer2(content: Text(association.bio ?? "aucune bio")),
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
              Section(
                  text: association.address ?? "no address",
                  icon: Icon(Icons.location_on_outlined)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(
                  text: association.email ?? "no email",
                  icon: Icon(Icons.mail)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: association.phone, icon: Icon(Icons.phone_android)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        AbstractContainer2(
            content: TitleWithIcon(
          icon: Icon(Icons.text_snippet_outlined),
          title: "Annones",
        )),
      ]),
    );
  }
}

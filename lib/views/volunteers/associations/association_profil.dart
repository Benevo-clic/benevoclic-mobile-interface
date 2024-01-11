import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/involved_associations/involved_association_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/container3.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class AssociationProfil extends StatelessWidget {
  Association association;
  BuildContext? context;

  AssociationProfil({super.key, required this.association, this.context});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          AppBarBackWidgetFct(
              fct: (value) => {
                    if (context == null)
                      {
                        BlocProvider.of<InvolvedAssociationCubit>(context)
                            .initState("")
                      }
                    else
                      {Navigator.pop(context)}
                  }),
          CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.25,
              backgroundImage: _getImageProvider(association.imageProfile ?? ""),
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
                  Text(association.volunteers?.length.toString() ??
                      "${association.volunteers!.length} bénévoles"),
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
          ContentWidget(content: Text(association.bio ?? "aucune bio")),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
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
                Section(
                    text: association.location?.address ?? "no address",
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
                Section(
                    text: association.phone, icon: Icon(Icons.phone_android)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          ContentWidget(
              content: TitleWithIcon(
            icon: Icon(Icons.text_snippet_outlined),
            title: "Annones",
          )),
        ]),
      ),
    );
  }
}

ImageProvider _getImageProvider(String? imageString) {
  if (isBase64(imageString)) {
    return MemoryImage(base64.decode(imageString!));
  } else {
    return NetworkImage(imageString!);
  }
}

bool isBase64(String? str) {
  if (str == null) return false;
  try {
    base64.decode(str);
    return true;
  } catch (e) {
    return false;
  }
}
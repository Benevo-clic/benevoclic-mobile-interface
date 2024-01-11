import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/involved_associations/involved_association_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

import '../../../widgets/bio_widget.dart';

class AssociationProfil extends StatelessWidget {
  Association association;
  int? nbAnnouncement;

  AssociationProfil(
      {super.key, required this.association, this.nbAnnouncement});

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
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          // Container3(
          //     content: Column(
          //   children: [
          //     Row(
          //       children: [
          //         Text(association.name),
          //         Expanded(child: Text("")),
          //         Text(association.volunteers?.length.toString() ??
          //             "${association.volunteers!.length} bénévoles"),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Button(
          //             text: "Adhérer",
          //             color: Colors.white,
          //             fct: () {},
          //             backgroundColor: Colors.green),
          //         Expanded(child: Text("")),
          //         Button(
          //             text: "Nous contacter",
          //             color: Colors.white,
          //             fct: () {},
          //             backgroundColor: orange)
          //       ],
          //     )
          //   ],
          // )),
          // SizedBox(
          //   height: MediaQuery.sizeOf(context).height * 0.03,
          // ),
          // ContentWidget(content: Text(association.bio ?? "aucune bio")),
          // SizedBox(
          //   height: MediaQuery.sizeOf(context).height * 0.03,
          // ),
          affichageAssociation(context),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          // ContentWidget(
          //     content: TitleWithIcon(
          //   icon: Icon(Icons.text_snippet_outlined),
          //   title: "Annones",
          // )),
        ]),
      ),
    );
  }

  Widget affichageAssociation(BuildContext context) {
    String? imageProfileAssociation =
        association.imageProfile ?? 'https://via.placeholder.com/150';
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AA4D4F,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.25,
              backgroundImage: _getImageProvider(imageProfileAssociation),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ContentWidget(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    association.name ?? "Pas de nom",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "${association.volunteers!.length} bénévoles",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BioWidget(
            title: "Description",
            description: association.bio ?? "Pas de description",
            sizeRaduis: true,
          ),
          ContentWidget(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Informations", icon: Icon(Icons.info_outline)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: association.location?.address ?? '',
                      icon: Icon(Icons.location_on_outlined)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: association.email ?? '',
                      icon: Icon(Icons.email_outlined)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: association.phone ?? "",
                      icon: Icon(Icons.phone_android)),
                ],
              ),
            ),
          ),
          ContentWidget(
            content: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.black,
                onSurface: Colors.grey,
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                // BlocProvider.of<PageCubit>(context).setPage(0);
              },
              icon: Icon(Icons.announcement),
              label: Text("Annonces ( ${nbAnnouncement ?? 0} )"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
        ],
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
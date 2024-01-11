import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/involved_associations/involved_association_cubit.dart';
import '../../../models/volunteer_model.dart';
import '../../../util/color.dart';
import '../../../widgets/app_bar_back.dart';
import '../../../widgets/bio_widget.dart';
import '../../../widgets/content_widget.dart';
import '../../../widgets/title_with_icon.dart';
import '../../common/profiles/widget/section_profil.dart';

class VolunteerProfil extends StatelessWidget {
  Volunteer volunteer;

  VolunteerProfil({super.key, required this.volunteer});

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
          affichageVolunteer(context),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
        ]),
      ),
    );
  }

  Widget affichageVolunteer(BuildContext context) {
    String? imageProfileVolunteer =
        volunteer.imageProfile ?? 'https://via.placeholder.com/150';

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
              backgroundImage: _getImageProvider(imageProfileVolunteer),
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
                    "${volunteer.firstName}  ${volunteer.lastName}",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "${volunteer.myAssociations?.length ?? 0} associations",
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
            description: volunteer.bio ?? "Pas de description",
            sizeRaduis: true,
          ),
          ContentWidget(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Mes informations",
                      icon: Icon(Icons.info_outline)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: volunteer.location?.address ?? '',
                      icon: Icon(Icons.location_on_outlined)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: volunteer.email ?? '',
                      icon: Icon(Icons.email_outlined)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  Section(
                      text: volunteer.phone ?? "",
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
              onPressed: () {},
              icon: Icon(Icons.history),
              label: Text("Nombres de missions effectuées"),
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

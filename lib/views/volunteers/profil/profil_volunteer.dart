import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/repositories/google/auth_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:namer_app/views/volunteers/profil/associations_view.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/announcement/announcement_state.dart';
import '../../../cubit/user/user_cubit.dart';
import '../../../cubit/volunteer/volunteer_state.dart';
import '../../../util/color.dart';
import '../../../util/showDialog.dart';
import '../../../widgets/app_bar_profil.dart';
import '../../../widgets/bio_widget.dart';
import '../../../widgets/title_with_icon.dart';
import '../../common/profiles/widget/section_profil.dart';

class ProfilPageVolunteer extends StatefulWidget {
  Volunteer volunteer;

  ProfilPageVolunteer({super.key, required this.volunteer});

  @override
  State<ProfilPageVolunteer> createState() => _ProfilPageVolunteerState();
}

class _ProfilPageVolunteerState extends State<ProfilPageVolunteer> {
  late Volunteer volunteer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    volunteer = widget.volunteer;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is VolunteerUpdateState) {
          volunteer = state.volunteerModel;
        }
        if (state is VolunteerLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: AppBarProfile(
              volunteer: volunteer,
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: affichageVolunteer(context),
                ),
              ),
            ],
          ),
        );
      },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssociationsSub(
                            associations: volunteer.myAssociations!,
                          ),
                        ),
                      );
                    },
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
              onPressed: () {
                // BlocProvider.of<PageCubit>(context).setPage(0);
              },
              icon: Icon(Icons.history),
              label: Text("Historique de missions"),
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
                ShowDialogYesNo.show(
                  context,
                  "Suppression de compte",
                  "Êtes-vous sûr de vouloir supprimer votre compte ?",
                  () async {
                    BlocProvider.of<VolunteerCubit>(context).deleteVolunteer();
                    BlocProvider.of<UserCubit>(context).deleteAccount();
                    AuthRepository().deleteAccount();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  },
                );
              },
              icon: Icon(Icons.remove_circle),
              label: Text("Suppression mon compte"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              BlocProvider.of<UserCubit>(context)
                  .disconnect()
                  .then((_) async => await AuthRepository().signOut());

              BlocProvider.of<AnnouncementCubit>(context)
                  .changeState(AnnouncementInitialState());

              final SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('Volunteer', false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    title: RulesType.USER_VOLUNTEER,
                    isLogin: true,
                  ),
                ),
              );
            },
            child: Text("Déconnexion"),
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


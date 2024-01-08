import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/repositories/google/auth_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/common/profiles/parameters/parameters.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:namer_app/views/volunteers/profil/announcements_view.dart';
import 'package:namer_app/views/volunteers/profil/associations_view.dart';
import 'package:namer_app/views/volunteers/profil/modif_profil.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/user/user_cubit.dart';

class ProfilPageVolunteer extends StatefulWidget {
  Volunteer volunteer;

  ProfilPageVolunteer({super.key, required this.volunteer});

  @override
  State<ProfilPageVolunteer> createState() => _ProfilPageVolunteerState();
}

class _ProfilPageVolunteerState extends State<ProfilPageVolunteer> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: getAppBarProfil(context),
      body: SingleChildScrollView(
        child: affichageVolunteer(context, widget.volunteer),
      ),
    );
  }
}

AppBar getAppBarProfil(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        icon: Icon(Icons.mode),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModifProfil()),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParametersView(
                      rule: RulesType.USER_VOLUNTEER,
                    )),
          );
        },
      ),
    ],
  );
}

class LineProfil extends StatelessWidget {
  final String text;
  final dynamic icon;

  const LineProfil({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
      content: Row(
        children: [
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () async {
                await AuthRepository().signOut();
              },
              icon: icon,
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class Bio extends StatelessWidget {
  final String text;

  Bio({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Text("Bio"), SizedBox(height: 5), Text(text)],
    ));
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

affichageVolunteer(BuildContext context, Volunteer volunteer) {
  String? imageProfileVolunteer =
      volunteer.imageProfile ?? 'https://via.placeholder.com/150';
  String bio = "";
  if (volunteer.bio != null) bio = volunteer.bio!;
  String? address = "";
  if (volunteer.location?.address != null) address = volunteer.location?.address;
  String email = "";
  if (volunteer.email != null) email = volunteer.email!;

  return Center(
    child: Column(
      children: [
        CircleAvatar(
          radius: MediaQuery.sizeOf(context).width * 0.25,
          backgroundImage: _getImageProvider(imageProfileVolunteer),
        ),
        SizedBox(
          height: 10,
        ),
        AbstractContainer2(
          content: Column(
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
                              )));
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
        SizedBox(
          height: 20,
        ),
        Bio(text: bio),
        SizedBox(
          height: 20,
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
              Section(text: address, icon: Icon(Icons.location_on_outlined)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: email, icon: Icon(Icons.mail)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: volunteer.phone, icon: Icon(Icons.phone_android)),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        LineProfil(
            text: "Historique de missions",
            icon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnnouncementView()));
              },
              icon: Icon(Icons.map_rounded),
            )),
        SizedBox(
          height: 20,
        ),
        LineProfil(
            text: "Suppression compte",
            icon: IconButton(
              onPressed: () async {
                BlocProvider.of<VolunteerCubit>(context).deleteVolunteer();
                BlocProvider.of<UserCubit>(context).deleteAccount();
                AuthRepository().deleteAccount();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              icon: Icon(Icons.no_accounts_sharp),
            )),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              BlocProvider.of<UserCubit>(context)
                  .disconnect()
                  .then((_) async => await AuthRepository().signOut());

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
            child: Text("Déconnexion")),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

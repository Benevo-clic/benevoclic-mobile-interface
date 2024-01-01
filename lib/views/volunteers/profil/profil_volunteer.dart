import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/repositories/auth_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/common/profiles/parameters/parameters.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:namer_app/views/volunteers/associations/associations_view.dart';
import 'package:namer_app/views/volunteers/profil/modif_profil.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/user/user_cubit.dart';

class ProfilPageVolunteer extends StatelessWidget {
  UserModel? user;
  Volunteer? volunteer;
  dynamic name = "corentin";

  getUser(BuildContext context) async {
    User user = FirebaseAuth.instance.currentUser!;
    volunteer = await context.read<VolunteerCubit>().getVolunteer(user.uid);
    name = volunteer!.lastName;
    await context.read<VolunteerCubit>().volunteerState(volunteer!);
  }

  @override
  Widget build(BuildContext context) {
    getUser(context);
    return BlocConsumer<VolunteerCubit, VolunteerState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(state);
          if (state is VolunteerInfo) {
            volunteer = state.getInfo();
            print(volunteer!.bio);
            return Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                appBar: getAppBarProfil(context),
                body: SingleChildScrollView(
                    child: affichageVolunteer(context, state.volunteer)));
          } else {
            return Scaffold(body: Text("oui"));
          }
        });
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

affichageVolunteer(BuildContext context, Volunteer volunteer) {
  String bio = "";
  if (volunteer.bio != null) bio = volunteer.bio!;
  String address = "";
  if (volunteer.address != null) address = volunteer.address!;
  String email = "";
  if (volunteer.email != null) email = volunteer.email!;

  return Center(
    child: Column(
      children: [
        Image.asset("assets/logo.png", height: 200),
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
              Text(
                "${volunteer.myAssociations?.length} associations",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AssociationsSub()));
              },
              icon: Icon(Icons.map_rounded),
            )),
        SizedBox(
          height: 20,
        ),
        LineProfil(
            text: "Paramètres",
            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
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
  /*
  return Column(
    children: [
      SizedBox(
        height: 50,
      ),
      Row(
        children: [
          Expanded(child: Text("")),
          IconButton(
            icon: Icon(Icons.perm_contact_calendar_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModifProfil()),
              );
            },
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParametersView()),
                );
              },
            ),
          ),
        ],
      ),
      Image.asset("assets/logo.png", height: 200),
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
            Text(
              "${volunteer.myAssociations!.length} associations",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Bio(text: volunteer.bio!),
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
            Section(
                text: volunteer.birthDayDate,
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
      SizedBox(
        height: 20,
      ),
      LineProfil(
          text: "Historique de missions",
          icon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.map_rounded),
          )),
      SizedBox(
        height: 20,
      ),
      LineProfil(
          text: "Paramètres",
          icon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )),
      SizedBox(
        height: 20,
      ),
      LineProfil(
          text: "Suppression compte",
          icon: IconButton(
            onPressed: () async {
              await AuthRepository().deleteAccount();
            },
            icon: Icon(Icons.no_accounts_sharp),
          )),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () async {

            BlocProvider.of<UserCubit>(context).disconnect().then((_) async => await AuthRepository().signOut());

                await AuthRepository().signOut();
                String owner = title == RulesType.USER_VOLUNTEER
                    ? 'Volunteer'
                    : "Association";
                final SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool(owner, false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(
                  title: title,
                ),
              ),
            );
          },
          child: Text("Déconnexion")),
      SizedBox(
        height: 20,
      ),
    );
  }
}

*/
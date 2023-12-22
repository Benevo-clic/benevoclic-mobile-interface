import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/common/profiles/modif_profil.dart';
import 'package:namer_app/views/common/profiles/parameters/parameters.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../repositories/auth_repository.dart';
import '../authentification/login/widgets/login.dart';
import 'modif_profil.dart';
import '../authentification/repository/auth_repository.dart';

class ProfileView extends StatelessWidget {
  final RulesType title;

  ProfileView({required this.title});

  getUser(BuildContext context) async {
  User user = FirebaseAuth.instance.currentUser!;
  volunteer = await context.read<VolunteerCubit>().getVolunteer(user.uid);
  name = volunteer!.lastName;
  await context.read<VolunteerCubit>().volunteerState(volunteer!);
  }

  @override
  Widget build(BuildContext context) {
    getUser(context);
    return Scaffold(
      body: Background(
        image: "assets/background4.png",
        widget: BlocConsumer<VolunteerCubit, VolunteerState>(
            listener: (context, state) {},
            builder: (context, state) {
              print(state);
              if (state is VolunteerInfo) {
                Volunteer volunteer = state.getInfo();

                return affichageVolunteer(context, volunteer);
              } else {
                return Text("");
              }
            }),
      ),
    );
  }
}

class LineProfil extends StatelessWidget {
  final String text;
  final icon;

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
                await AuthRepository().logout();
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
      children: [
        Text("Bio"),
        SizedBox(height: 5),
        Text(
            text)
      ],
    ));
  }
}

affichageVolunteer(BuildContext context, Volunteer volunteer) {
  return ListView(
    padding: EdgeInsets.all(25),
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
      Text(volunteer.firstName, style: TextStyle()),
      SizedBox(
        height: 20,
      ),
      Bio(text: volunteer.bio!),
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

class LineProfil extends StatelessWidget {
  final String text;
  final icon;

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
      children: [
        Text("Bio"),
        SizedBox(height: 5),
        Text(
            "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. ")
      ],
    ));
  }
}

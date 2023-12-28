import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/associtions/profil/modif_profil_asso.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/common/profiles/parameters/parameters.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:namer_app/views/volunteers/associations/associations_view.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../common/authentification/repository/auth_repository.dart';

class ProfilPageAssociation extends StatelessWidget {
  Association association =
      Association(name: "name", phone: "phone", type: "type");
  dynamic name = "corentin";

  getUserType(BuildContext context) {
    getAssociation(context);
  }

  getAssociation(BuildContext context) async {
    User user = FirebaseAuth.instance.currentUser!;
    association =
        await context.read<AssociationCubit>().getAssociation(user.uid);
    context.read<AssociationCubit>().stateInfo(association);
  }

  @override
  Widget build(BuildContext context) {
    getUserType(context);

    return BlocConsumer<AssociationCubit, AssociationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AssociationConnexion) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              appBar: getAppBarProfil(context, state.association),
              body: SingleChildScrollView(
                  child: affichageAssociation(context, state.association!)));
        } else {
          return Text("");
        }
      },
    );
  }
}

AppBar getAppBarProfil(BuildContext context, association) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        icon: Icon(Icons.mode),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ModifProfilAsso(
                      association: association,
                    )),
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
                      rule: RulesType.USER_ASSOCIATION,
                    )),
          );
        },
      ),
    ],
  );
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
      children: [Text("Bio"), SizedBox(height: 5), Text(text)],
    ));
  }
}

affichageAssociation(BuildContext context, Association association) {
  String bio = "";
  String address = "";
  if (association.bio != null) bio = association.bio!;
  if (association.address != null) address = association.address!;
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
                "${association.name}",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              Text(
                "${association.volunteers?.length} associations",
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
              Section(text: association.phone, icon: Icon(Icons.phone_android)),
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
                BlocProvider.of<AssociationCubit>(context).deleteAccount();
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
              await AuthRepository().logout();
              BlocProvider.of<UserCubit>(context).disconnect();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    title: RulesType.USER_VOLUNTEER,
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

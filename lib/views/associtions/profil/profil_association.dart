import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/cubit/page/page_cubit.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/repositories/google/auth_repository.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/associtions/members/members_view.dart';
import 'package:namer_app/views/associtions/profil/update_profil_association.dart';
import 'package:namer_app/views/common/authentification/login/widgets/login.dart';
import 'package:namer_app/views/common/profiles/parameters/parameters.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/views/home_view.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:namer_app/widgets/title_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/user/user_cubit.dart';
import '../../../util/color.dart';
import '../../../util/showDialog.dart';
import '../../../widgets/app_bar_profil.dart';
import '../../../widgets/bio_widget.dart';

class ProfilPageAssociation extends StatefulWidget {
  Association? association;

  ProfilPageAssociation({super.key, required this.association});

  @override
  State<ProfilPageAssociation> createState() => _ProfilPageAssociationState();
}

class _ProfilPageAssociationState extends State<ProfilPageAssociation> {
  late Association association;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    association = widget.association!;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AssociationUpdateState) {
          if (state.association != null) {
            association = state.association!;
          }
        }
        if (state is AssociationLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: AppBarProfile(
              association: association,
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: affichageAssociation(context),
                ),
              )
            ],
          ),
        );
      },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MembersView(
                              volunteers: association.volunteers ?? []),
                        ),
                      );
                    },
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
                    title: "Mes informations", icon: Icon(Icons.info_outline)),
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
                BlocProvider.of<PageCubit>(context).setPage(0);
              },
              icon: Icon(Icons.announcement),
              label: Text("Mes annonces"),
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
                    BlocProvider.of<AssociationCubit>(context).deleteAccount();
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

                final SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool('Association', false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      title: RulesType.USER_ASSOCIATION,
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

AppBar getAppBarProfil(BuildContext context, association) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return AppBar(
    elevation: 0,
    backgroundColor: Color.fromRGBO(255, 153, 85, 1),
    title: IconButton(
      icon: Image.asset(
        'assets/logo.png',
        width: width * .11,
        height: height * .07,
      ),
      onPressed: () {},
    ),
    actions: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        width: 30,
        child: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/pencil.svg",
            height: height * .02,
            color: Colors.black,
          ),
          onPressed: () {
            BlocProvider.of<AssociationCubit>(context).changeState(
                AssociationUpdatingState(associationModel: association));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfileAssociation(
                  association: association,
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        width: 30,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParametersView(
                  rule: RulesType.USER_ASSOCIATION,
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(
        width: 15,
      ),
    ],
  );
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

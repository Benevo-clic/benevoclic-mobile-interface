import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/buildNavigation_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/associtions/publish/publish_association_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/announcement/announcement_cubit.dart';
import '../../cubit/page/page_cubit.dart';
import '../../repositories/api/association_repository.dart';
import '../../widgets/build_navbar.dart';
import '../common/messages/messages.dart';
import 'announcement/announcement_association.dart';
import 'profil/profil_association.dart';

class NavigationAssociation extends StatefulWidget {
  const NavigationAssociation({super.key});

  @override
  State<NavigationAssociation> createState() => _NavigationAssociationState();
}

class _NavigationAssociationState extends State<NavigationAssociation> {
  int currentPageIndex = 0;
  String _idAssociation = '';

  Association? association;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
    BlocProvider.of<PageCubit>(context).setPage(0);
  }

  @override
  void initState() {
    super.initState();
    _idAssociation = '';
  }

  init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _idAssociation = preferences.getString('idAssociation')!;
    });

    if (_idAssociation.isNotEmpty) {
      var currentAssociation =
          await AssociationRepository().getAssociation(_idAssociation);

      if (currentAssociation == null) {
        return;
      }
      if (!mounted) return;
      setState(() {
        association = currentAssociation;
      });
    }
  }

  Future<void> onPageChanged(int newIndex) async {
    if (newIndex == 0) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      if (!mounted) return;

      String idAssociation = preferences.getString('idAssociation')!;
      BlocProvider.of<AnnouncementCubit>(context)
          .getAllAnnouncementByAssociation(idAssociation);
    }
  }

  List<BuildNavigationModel> buildNavigationModel = [
    BuildNavigationModel(
      iconTitle: 'assets/icons/Menu.svg',
      label: 'Annonces',
      size: 41,
    ),
    BuildNavigationModel(
        iconTitle: 'assets/icons/Chat_alt.svg', label: 'Publier', size: 41),
    BuildNavigationModel(iconTitle: 'assets/icons/chat.svg', label: 'Messages'),
    BuildNavigationModel(
      iconTitle: 'assets/icons/profile.svg', label: 'Profil', size: 41),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuldNavBar(
        buildNavigationModel: buildNavigationModel,
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          if (association == null) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          onPageChanged(currentPageIndex);
          if (_idAssociation.isNotEmpty) {
            BlocProvider.of<AnnouncementCubit>(context)
                .getAllAnnouncementByAssociation(_idAssociation);
          }
          return IndexedStack(
            index: currentPageIndex,
            children: [
              AnnouncementAssociation(
                idAssociation: _idAssociation,
              ),
              PublishAnnouncement(),
              Messages(rulesType: RulesType.USER_ASSOCIATION),
              ProfilPageAssociation(association: association),
            ],
          );
        },
      ),
    );
  }
}

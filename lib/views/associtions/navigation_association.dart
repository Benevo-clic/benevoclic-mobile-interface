import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/buildNavigation_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/associtions/publish/publish_association_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/announcement/announcement_cubit.dart';
import '../../cubit/page/page_cubit.dart';
import '../../widgets/build_navbar.dart';
import '../common/annonces/announcement_common.dart';
import '../common/messages/messages.dart';
import 'profil/profil_association.dart';

class NavigationAssociation extends StatefulWidget {
  const NavigationAssociation({super.key});

  @override
  State<NavigationAssociation> createState() => _NavigationAssociationState();
}

class _NavigationAssociationState extends State<NavigationAssociation> {
  int currentPageIndex = 0;
  late String _idAssociation; // Make it nullable

  @override
  void initState() {
    super.initState();
    _idAssociation = '';
    init();
  }

  Future<void> onPageChanged(int newIndex) async {
    if (newIndex == 0) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String idAssociation = preferences.getString('idAssociation')!;
      BlocProvider.of<AnnouncementCubit>(context)
          .getAllAnnouncementByAssociation(idAssociation);
    }
  }

  Future<void> init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _idAssociation = preferences.getString('idAssociation')!;
    // Future.delayed(Duration(seconds: 1), () {});
    BlocProvider.of<AnnouncementCubit>(context)
        .getAllAnnouncementByAssociation(_idAssociation);
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
          onPageChanged(currentPageIndex);
          return IndexedStack(
            index: currentPageIndex,
            children: [
              AnnouncementCommon(
                rulesType: RulesType.USER_ASSOCIATION,
                idAssociation: _idAssociation,
              ),
              PublishAnnouncement(),
              Messages(),
              ProfilPageAssociation(),
            ],
          );
        },
      ),
    );
  }
}

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
  String _idAssociation = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? savedIdAssociation = preferences.getString('idAssociation');
      if (savedIdAssociation != null && savedIdAssociation.isNotEmpty) {
        if (mounted) {
          setState(() {
            _idAssociation = savedIdAssociation;
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération de _idAssociation: $e');
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
    if (_idAssociation.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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

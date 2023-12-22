import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/models/buildNavigation_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/associtions/publish/publish_association_views.dart';
import 'package:namer_app/widgets/build_navbar.dart';

import '../../cubit/page/page_cubit.dart';
import '../common/annonces/announcement_common.dart';
import '../common/messages/messages.dart';
import '../common/profiles/profil.dart';

class NavigationAssociation extends StatefulWidget {
  const NavigationAssociation({super.key});

  @override
  State<NavigationAssociation> createState() => _NavigationAssociationState();
}

class _NavigationAssociationState extends State<NavigationAssociation> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    AnnouncementCommon(),
    PublishAnnouncement(),
    Messages(),
    ProfileView(title: RulesType.USER_ASSOCIATION),
  ];

  void navigateToPublishPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PublishAnnouncement()),
    );
  }

  Widget buildNavigationIcon(String assetName, int index, {double? size}) {
    final bool isSelected = index == currentPageIndex;

    if (isSelected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetName,
            height: size ?? 24,
            color: Color.fromRGBO(55, 94, 232, 1),
          ),
        ],
      );
    } else {
      return SvgPicture.asset(
        assetName,
        height: size ?? 24,
      );
    }
  }

  List<BuildNavigationModel> buildNavigationModel = [
    BuildNavigationModel(iconTitle: 'assets/icons/Menu.svg', label: 'Annonces'),
    BuildNavigationModel(
        iconTitle: 'assets/icons/Chat_alt.svg', label: 'Publier', size: 45),
    BuildNavigationModel(iconTitle: 'assets/icons/chat.svg', label: 'Messages'),
    BuildNavigationModel(
      iconTitle: 'assets/icons/profile.svg',
      label: 'Profil',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: marron, width: 2)), // Votre style
        ),
        child: BuldNavBar(
          buildNavigationModel: buildNavigationModel,
          onItemTapped: (index) {
            if (index == 1) {
              navigateToPublishPage();
            } else {
              context.read<PageCubit>().setPage(index);
            }
          },
        ),
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          return IndexedStack(
            index: currentPageIndex,
            children: pages,
          );
        },
      ),
    );
  }
}

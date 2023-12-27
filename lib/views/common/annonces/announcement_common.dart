import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement_association.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement_volunteer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../type/rules_type.dart';
import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  final RulesType rulesType;

  const AnnouncementCommon({super.key, required this.rulesType});
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  List<Announcement> announcements = [];
  List<Announcement> announcementsAssociation = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) async {
      if (state is AnnouncementLoadedState) {
        setState(() {
          announcements = state.announcements;
        });
      }
      if (state is AnnouncementLoadedStateWithoutAnnouncements) {
        setState(() {
          announcementsAssociation = state.announcements;
        });
      }
      if (state is DeleteAnnouncementState) {
        SnackBar snackBar = SnackBar(
          content: Text('Annonce supprimée'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        String idAssociation = preferences.getString('idAssociation')!;
        BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
        BlocProvider.of<AnnouncementCubit>(context)
            .getAllAnnouncementByAssociation(idAssociation);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
              0.15), // Hauteur personnalisée
          child: AppBarSearch(
            contexts: context,
            label: 'Annonces',
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (widget.rulesType == RulesType.USER_ASSOCIATION) {
                int reversedIndex = announcementsAssociation.length - index - 1;
                return ItemAnnouncementAssociation(
                  announcement: announcementsAssociation[reversedIndex],
                );
              }
              int reversedIndex = announcements.length - index - 1;

              return ItemAnnouncementVolunteer(
                announcement: announcements[reversedIndex],
                isSelected: false,
              );
            },
            itemCount: widget.rulesType == RulesType.USER_ASSOCIATION
                ? announcementsAssociation.length
                : announcements.length,
          ),
        ),
      );
    });
  }
}


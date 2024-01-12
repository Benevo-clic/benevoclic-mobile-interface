import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/views/volunteers/announcement/item_announcement_volunteer.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../widgets/app_bar_search.dart';

class AnnouncementNoIndentify extends StatefulWidget {
  const AnnouncementNoIndentify();

  @override
  State<AnnouncementNoIndentify> createState() =>
      _AnnouncementNoIndentifyState();
}

class _AnnouncementNoIndentifyState extends State<AnnouncementNoIndentify> {
  List<Announcement> announcements = [];
  List<Announcement> announcementsAssociation = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];
    if (currentState is AnnouncementLoadedState) {
      loadedAnnouncements = currentState.announcements;
    }
    print('Announcements: ${loadedAnnouncements.length}');
    return loadedAnnouncements;
  }

  void _handleSearchChanged(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  void _handleAnnouncementFilterChanged(List<Announcement>? announcements) {
    setState(() {
      this.announcements = announcements!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarSearch(
            contexts: context,
            label: 'Annonces',
            onSearchChanged: _handleSearchChanged,
            onAnnouncementsChanged: _handleAnnouncementFilterChanged),
      ),
      body: BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementLoadedState) {
            setState(() {
              announcements = state.announcements
                  .where((element) => element.isVisible ?? true)
                  .toList();
            });
          }
        },
        builder: (context, state) {
          if (state is AnnouncementLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return _buildAnnouncementsList(announcements);
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          int reversedIndex = announcements.length - index - 1;
          Announcement announcement = announcements[reversedIndex];
          return ItemAnnouncementVolunteer(
              announcement: announcement,
              isSelected: false,
              nbAnnouncementsAssociation: announcements
                  .where((element) =>
                      element.idAssociation == announcement.idAssociation)
                  .length);
        },
        itemCount: announcements.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../models/announcement_model.dart';
import '../../../models/association_model.dart';
import '../../../util/color.dart';
import '../../../widgets/app_bar_search.dart';
import 'item_announcement_association.dart';

class AnnouncementAssociation extends StatefulWidget {
  final String? idAssociation;

  AnnouncementAssociation({super.key, this.idAssociation});

  @override
  State<AnnouncementAssociation> createState() =>
      _AnnouncementAssociationState();
}

class _AnnouncementAssociationState extends State<AnnouncementAssociation> {
  List<Announcement> announcementsAssociation = [];
  String _searchQuery = '';
  Association? association;

  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];

    // print(currentState.toString() + "2");
    if (currentState is AnnouncementLoadedStateWithoutAnnouncements &&
        widget.idAssociation != null) {
      loadedAnnouncements = currentState.announcements;
    }

    if (currentState is AnnouncementLoadedStateAfterFilter) {
      loadedAnnouncements = currentState.announcements;
    }

    if (_searchQuery.isNotEmpty && _searchQuery != '') {
      loadedAnnouncements = loadedAnnouncements
          .where((element) =>
              element.labelEvent
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.nameAssociation
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return loadedAnnouncements;
  }

  void _handleSearchChanged(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  List<Announcement> _handleAnnouncementFilterChanged(
      List<Announcement>? announcements) {
    setState(() {
      announcementsAssociation = announcements!;
      BlocProvider.of<AnnouncementCubit>(context).changeState(
          AnnouncementLoadedStateWithoutAnnouncements(
              announcements: announcementsAssociation));
    });
    return announcements!;
  }

  void _applySearchFilter(List<Announcement> announcementsList) {
    if (_searchQuery.isNotEmpty && _searchQuery != '') {
      announcementsAssociation = announcementsList
          .where((element) =>
              element.labelEvent
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.nameAssociation
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      announcementsAssociation = announcementsList;
    }
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
            idAssociation: widget.idAssociation,
            onAnnouncementsChanged: _handleAnnouncementFilterChanged),
      ),
      body: BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementLoadedStateWithoutAnnouncements) {
            announcementsAssociation = state.announcements;
          } else if (state is AnnouncementErrorState) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is DeleteAnnouncementState) {
            _showSnackBar(context, 'Annonce supprimée', Colors.green);
            _reloadData();
          } else if (state is HideAnnouncementState) {
            if (state.isVisible == true)
              _showSnackBar(context, 'Annonce affichée', Colors.green);
            else
              _showSnackBar(context, 'Annonce cachée', Colors.green);
            _reloadData();
          }
        },
        builder: (context, state) {
          if (state is AnnouncementErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is AnnouncementLoadedStateWithoutAnnouncements) {
            _applySearchFilter(state.announcements);
          }

          return FutureBuilder<List<Announcement>>(
            future: _processAnnouncements(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // print('waiting');
                return SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : marron,
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return _buildEmptyList();
              }
              if (!snapshot.hasData) {
                return Center(child: Text('Aucune annonce disponible'));
              }
              final announcements = snapshot.data!;
              return _buildAnnouncementsList(announcements);
            },
          );
        },
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    if (announcements.isEmpty) {
      return _buildEmptyList();
    }
    return _buildListViewAnnouncementsAssociation(announcements);
  }

  Widget _buildListViewAnnouncementsAssociation(
      List<Announcement> announcements) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          int reversedIndex = announcements.length - index - 1;
          return ItemAnnouncementAssociation(
              announcement: announcements[reversedIndex],
              nbAnnouncementsAssociation: announcements.length);
        },
        itemCount: announcements.length,
      ),
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aucune annonce trouvée',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String idAssociation = widget.idAssociation!;
              BlocProvider.of<AnnouncementCubit>(context)
                  .getAllAnnouncementByAssociation(idAssociation);
            },
            child: Text('Recharger'),
          ),
        ],
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

  Future<void> _reloadData() async {
    String idAssociation = widget.idAssociation!;
    BlocProvider.of<AnnouncementCubit>(context)
        .getAllAnnouncementByAssociation(idAssociation);
  }
}

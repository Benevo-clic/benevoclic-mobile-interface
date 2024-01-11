import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/util/color.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import '../../../models/announcement_model.dart';
import '../../../repositories/api/favorites_repository.dart';
import '../../../widgets/app_bar_search.dart';
import 'item_announcement_volunteer.dart';

class AnnouncementVolunteer extends StatefulWidget {
  final String? idVolunteer;

  AnnouncementVolunteer({super.key, this.idVolunteer});

  @override
  State<AnnouncementVolunteer> createState() => _AnnouncementVolunteerState();
}

class _AnnouncementVolunteerState extends State<AnnouncementVolunteer> {
  List<Announcement> announcements = [];
  FavoritesRepository _favoritesRepository = FavoritesRepository();
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _processAnnouncements();
  }

  void _toggleFavorite(Announcement announcement) async {
    final isFavorite = await _favoritesRepository.isFavorite(
        widget.idVolunteer, announcement.id!);
    if (isFavorite) {
      print('remove');
      BlocProvider.of<FavoritesAnnouncementCubit>(context)
          .removeFavoritesAnnouncement(widget.idVolunteer, announcement.id!);
    } else {
      print('add');
      BlocProvider.of<FavoritesAnnouncementCubit>(context)
          .addFavoritesAnnouncement(widget.idVolunteer, announcement.id!);
    }

    setState(() {
      announcement.isFavorite = !isFavorite;
    });
  }

  Future<bool> _checkIfFavorite(
      String? idVolunteer, String? idAnnouncement) async {
    return await _favoritesRepository.isFavorite(idVolunteer, idAnnouncement!);
  }

  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 1000));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];
    if (currentState is AnnouncementLoadedState) {
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
    setState(() {
      announcements = loadedAnnouncements;
    });

    return await _updateFavoriteStatus(loadedAnnouncements);
  }

  void _handleSearchChanged(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  Future<List<Announcement>> _updateFavoriteStatus(
      List<Announcement> announcements) async {
    final updatedAnnouncements =
        await Future.wait(announcements.map((announcement) async {
      final isFavorite =
          await _checkIfFavorite(widget.idVolunteer, announcement.id);
      return announcement.copyWith(isFavorite: isFavorite);
    }));
    announcements = updatedAnnouncements
        .where((element) => element.isVisible ?? true)
        .toList();
    setState(() {
      this.announcements = announcements;
    });
    return announcements;
  }

  List<Announcement> _handleAnnouncementFilterChanged(
      List<Announcement>? announcements) {
    setState(() {
      this.announcements = announcements!;
      BlocProvider.of<AnnouncementCubit>(context).changeState(
          AnnouncementLoadedState(announcements: this.announcements));
    });
    return announcements!;
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
              _updateFavoriteStatus(state.announcements);
              announcements = state.announcements
                  .where((element) => element.isVisible ?? true)
                  .toList();
            });
          }
          if (state is AnnouncementRemovedParticipateState) {
            BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
          }
          if (state is AnnouncementRemovedWaitingState) {
            BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
          }
          if (state is AnnouncementAddedParticipateState) {
            BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
          }
          if (state is AnnouncementAddedWaitingState) {
            BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
          }
        },
        builder: (context, state) {
          if (state is AnnouncementLoadingVolunteerState) {
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
          if (state is AnnouncementVolunteerErrorState) {
            return Center(child: Text('Erreur de chargement'));
          }
          return _buildAnnouncementsList(announcements);
        },
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    if (announcements.isEmpty) {
      return _buildEmptyList();
    }
    return _buildListViewAnnouncementsVolunteer(announcements);
  }

  Widget _buildListViewAnnouncementsVolunteer(
      List<Announcement> announcements) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          int reversedIndex = announcements.length - index - 1;
          Announcement announcement = announcements[reversedIndex];
          return ItemAnnouncementVolunteer(
              announcement: announcement,
              idVolunteer: widget.idVolunteer,
              isSelected: announcement.isFavorite ?? false,
              toggleFavorite: () => _toggleFavorite(announcement),
              nbAnnouncementsAssociation: announcements
                  .where((element) =>
                      element.idAssociation == announcement.idAssociation)
                  .length);
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
              BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
            },
            child: Text('Recharger'),
          ),
        ],
      ),
    );
  }
}

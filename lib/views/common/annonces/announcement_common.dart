import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/views/associtions/announcement/item_announcement_association.dart';
import 'package:namer_app/views/volunteers/announcement/item_announcement_volunteer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import '../../../repositories/api/favorites_repository.dart';
import '../../../type/rules_type.dart';
import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  final RulesType rulesType;
  final String? idVolunteer;

  const AnnouncementCommon(
      {super.key, required this.rulesType, this.idVolunteer});
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  List<Announcement> announcements = [];
  List<Announcement> announcementsAssociation = [];
  FavoritesRepository _favoritesRepository = FavoritesRepository();


  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorite(Announcement announcement) async {
    final isFavorite = await _favoritesRepository.isFavorite(
        widget.idVolunteer, announcement.id!);
    if (isFavorite) {
      BlocProvider.of<FavoritesAnnouncementCubit>(context)
          .removeFavoritesAnnouncement(widget.idVolunteer, announcement.id!);
    } else {
      BlocProvider.of<FavoritesAnnouncementCubit>(context)
          .addFavoritesAnnouncement(widget.idVolunteer, announcement.id!);
    }

    setState(() {
      announcement.isFavorite = !isFavorite;
    });
  }

  Future<bool> _checkIfFavorite(
      String idVolunteer, String? idAnnouncement) async {
    return await _favoritesRepository.isFavorite(idVolunteer, idAnnouncement!);
  }


  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];
    if (currentState is AnnouncementLoadedState) {
      loadedAnnouncements = currentState.announcements;
    }
    return await _updateFavoriteStatus(loadedAnnouncements);
  }

  Future<List<Announcement>> _updateFavoriteStatus(
      List<Announcement> announcements) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String idVolunteer = prefs.getString('idVolunteer') ?? '';
    final updatedAnnouncements =
        await Future.wait(announcements.map((announcement) async {
      final isFavorite = await _checkIfFavorite(idVolunteer, announcement.id);
      return announcement.copyWith(isFavorite: isFavorite);
    }));
    announcements = updatedAnnouncements
        .where((element) => element.isVisible ?? true)
        .toList();
    return announcements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarSearch(contexts: context, label: 'Annonces'),
      ),
      body: BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementLoadedState) {
            setState(() {
              announcements = state.announcements
                  .where((element) => element.isVisible ?? true)
                  .toList();
            });
          } else if (state is AnnouncementLoadedStateWithoutAnnouncements) {
            setState(() {
              announcementsAssociation = state.announcements;
            });
          } else if (state is AnnouncementErrorState) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is DeleteAnnouncementState) {
            _showSnackBar(context, 'Annonce supprimée', Colors.green);
            _reloadData();
            _reloadDataVolunteer();
          } else if (state is HideAnnouncementState) {
            if (state.isVisible == true)
              _showSnackBar(context, 'Annonce affichée', Colors.green);
            else
              _showSnackBar(context, 'Annonce cachée', Colors.green);
            _reloadData();
            _reloadDataVolunteer();
          }
        },
        builder: (context, state) {
          if (state is AnnouncementLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return FutureBuilder<List<Announcement>>(
            future: _processAnnouncements(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Erreur lors du chargement des annonces'));
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

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _reloadData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String idAssociation = preferences.getString('idAssociation') ?? '';
    BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
    BlocProvider.of<AnnouncementCubit>(context)
        .getAllAnnouncementByAssociation(idAssociation);
  }

  Future<void> _reloadDataVolunteer() async {
    BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (widget.rulesType == RulesType.USER_ASSOCIATION) {
            int reversedIndex = announcementsAssociation.length - index - 1;
            return ItemAnnouncementAssociation(
                announcement: announcementsAssociation[reversedIndex],
                nbAnnouncementsAssociation: announcementsAssociation.length);
          } else {
            int reversedIndex = announcements.length - index - 1;
            Announcement announcement = announcements[reversedIndex];
            return ItemAnnouncementVolunteer(
              announcement: announcement,
              isSelected: announcement.isFavorite ?? false,
              toggleFavorite: () => _toggleFavorite(announcement),
                nbAnnouncementsAssociation: announcements
                    .where((element) =>
                        element.idAssociation == announcement.idAssociation)
                    .length);
          }
        },
        itemCount: widget.rulesType == RulesType.USER_ASSOCIATION
            ? announcementsAssociation.length
            : announcements.length,
      ),
    );
  }
}
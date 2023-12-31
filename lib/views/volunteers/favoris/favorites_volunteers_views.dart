import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import 'package:namer_app/cubit/favorisAnnouncement/favorites_announcement_state.dart';
import 'package:namer_app/repositories/api/announcement_repository.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../../cubit/announcement/announcement_state.dart';
import '../../../models/announcement_model.dart';
import '../../../repositories/api/favorites_repository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../common/annonces/widgets/item_announcement_volunteer.dart';

class FavoritesVolunteer extends StatefulWidget {
  final RulesType rulesType;
  final String idVolunteer;

  const FavoritesVolunteer(
      {super.key, required this.rulesType, required this.idVolunteer});

  @override
  State<FavoritesVolunteer> createState() => _FavoritesVolunteerState();
}

class _FavoritesVolunteerState extends State<FavoritesVolunteer> {
  List<String?> idAnnouncements = [];

  FavoritesRepository _favoritesRepository = FavoritesRepository();
  AnnouncementRepository _announcementRepository = AnnouncementRepository();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoritesAnnouncementCubit>(context)
        .getFavoritesAnnouncementByVolunteerId(widget.idVolunteer);
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
  }

  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];
    if (currentState is AnnouncementLoadedState) {
      loadedAnnouncements = currentState.announcements;
    }
    List<Announcement> announcements =
        await _announcementRepository.getAnnouncements();

    print('announcements: $announcements');

    return loadedAnnouncements;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesAnnouncementCubit, FavoritesAnnouncementState>(
      listener: (context, state) {
        if (state is FavoritesAnnouncementErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is FavoritesAnnouncementLoadingState) {
          BlocProvider.of<FavoritesAnnouncementCubit>(context)
              .getFavoritesAnnouncementByVolunteerId(widget.idVolunteer);
          return Center(child: CircularProgressIndicator());
        }

        if (state is FavoritesAnnouncementLoadedState) {
          idAnnouncements = state.favoritesAnnouncement.announcementFavorites
              .map((e) => e.id)
              .toList();
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
                0.15), // Hauteur personnalisée
            child: AppBarWidget(contexts: context, label: 'Mes Favoris'),
          ),
          body: FutureBuilder<List<Announcement>>(
            future: _processAnnouncements(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final filteredAnnouncements = snapshot.data!
                    .where((announcement) =>
                        isAnnouncementInList(announcement, idAnnouncements))
                    .map((e) => e.copyWith(isFavorite: true))
                    .toList();
                return _buildAnnouncementsList(
                    filteredAnnouncements, _toggleFavorite);
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }

  bool isAnnouncementInList(Announcement announcement, List<String?> ids) {
    return ids.contains(announcement.id);
  }

  Widget _buildAnnouncementsList(
      List<Announcement> filteredAnnouncements, Function _toggleFavorite) {
    return ListView.builder(
      itemCount: filteredAnnouncements.length,
      itemBuilder: (context, index) {
        Announcement announcement = filteredAnnouncements[index];
        return ItemAnnouncementVolunteer(
          announcement: announcement,
          isSelected: announcement.isFavorite ?? false,
          toggleFavorite: () => _toggleFavorite(announcement),
          nbAnnouncementsAssociation: 0,
        );
      },
    );
  }
}

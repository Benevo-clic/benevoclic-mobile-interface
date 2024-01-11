import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import 'package:namer_app/cubit/favorisAnnouncement/favorites_announcement_state.dart';

import '../../../models/announcement_model.dart';
import '../../../repositories/api/favorites_repository.dart';
import '../../../util/color.dart';
import '../../../widgets/app_bar_widget.dart';
import '../announcement/item_announcement_volunteer.dart';

class FavoritesVolunteer extends StatefulWidget {
  final String idVolunteer;

  const FavoritesVolunteer({super.key, required this.idVolunteer});

  @override
  State<FavoritesVolunteer> createState() => _FavoritesVolunteerState();
}

class _FavoritesVolunteerState extends State<FavoritesVolunteer> {
  List<String?> idAnnouncements = [];
  List<Announcement> announcements = [];

  FavoritesRepository _favoritesRepository = FavoritesRepository();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FavoritesAnnouncementCubit>(context)
        .getFavoritesAnnouncementByVolunteerId(widget.idVolunteer);
  }

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
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesAnnouncementCubit, FavoritesAnnouncementState>(
      listener: (context, state) {
        if (state is FavoritesAnnouncementErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is FavoritesAnnouncementLoadedState) {
            announcements = state.favoritesAnnouncement.announcementFavorites;
        }
        if (state is FavoritesAnnouncementAddingState) {
          BlocProvider.of<FavoritesAnnouncementCubit>(context)
              .getFavoritesAnnouncementByVolunteerId(widget.idVolunteer);
        }

        if (state is FavoritesAnnouncementRemovingState) {
          BlocProvider.of<FavoritesAnnouncementCubit>(context)
              .getFavoritesAnnouncementByVolunteerId(widget.idVolunteer);
        }
        if (state is FavoritesAnnouncementLoadedState) {
          idAnnouncements = state.favoritesAnnouncement.announcementFavorites
              .map((e) => e.id)
              .where((element) => element != null)
              .toList();
        }
      },
      builder: (context, state) {
        if (state is FavoritesAnnouncementLoadingState) {
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

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
            child: AppBarWidget(contexts: context, label: 'Mes Favoris'),
          ),
          body: _buildAnnouncementsList(announcements, _toggleFavorite),
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
          idVolunteer: widget.idVolunteer,
          isSelected: true,
          toggleFavorite: () => _toggleFavorite(announcement),
          nbAnnouncementsAssociation: announcements
              .where((element) =>
                  element.idAssociation == announcement.idAssociation)
              .length,
        );
      },
    );
  }
}

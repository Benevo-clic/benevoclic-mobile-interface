import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/views/associtions/announcement/item_announcement_association.dart';
import 'package:namer_app/views/volunteers/announcement/item_announcement_volunteer.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import '../../../repositories/api/favorites_repository.dart';
import '../../../type/rules_type.dart';
import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  final RulesType rulesType;
  final String? idVolunteer;
  final String? idAssociation;

  const AnnouncementCommon(
      {super.key,
      required this.rulesType,
      this.idVolunteer,
      this.idAssociation});
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  List<Announcement> announcements = [];
  List<Announcement> announcementsAssociation = [];
  Association? association;
  FavoritesRepository _favoritesRepository = FavoritesRepository();
  String _searchQuery = '';
  late final String idVolunteer;
  late final String idAssociation;

  @override
  void initState() {
    super.initState();
    print(widget.idAssociation);
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

  Future<bool> _checkIfFavorite(String? idVolunteer,
      String? idAnnouncement) async {
    return await _favoritesRepository.isFavorite(idVolunteer, idAnnouncement!);
  }


  Future<List<Announcement>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    final currentState = BlocProvider.of<AnnouncementCubit>(context).state;
    List<Announcement> loadedAnnouncements = [];
    if (currentState is AnnouncementLoadedState) {
      loadedAnnouncements = currentState.announcements;
    }
    if (currentState is AnnouncementLoadedStateWithoutAnnouncements) {
      loadedAnnouncements = currentState.announcements;
    }

    if (currentState is AnnouncementLoadedStateAfterFilter) {
      if (announcementsAssociation.isNotEmpty) {
        loadedAnnouncements = announcementsAssociation;
      } else {
        loadedAnnouncements = currentState.announcements;
      }
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

    return await _updateFavoriteStatus(loadedAnnouncements);
  }

  Future<List<Announcement>> _updateFavoriteStatus(
      List<Announcement> announcements) async {
    if (widget.rulesType == RulesType.USER_ASSOCIATION) {
      return announcements;
    }

    final updatedAnnouncements =
        await Future.wait(announcements.map((announcement) async {
      final isFavorite =
          await _checkIfFavorite(widget.idVolunteer, announcement.id);
      return announcement.copyWith(isFavorite: isFavorite);
    }));
    announcements = updatedAnnouncements
        .where((element) => element.isVisible ?? true)
        .toList();
    return announcements;
  }

  void _handleSearchChanged(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  List<Announcement> _handleAnnouncementFilterChanged(
      List<Announcement>? announcements) {
    setState(() {
      if (widget.rulesType == RulesType.USER_ASSOCIATION) {
        announcementsAssociation = announcements!;
        BlocProvider.of<AnnouncementCubit>(context).changeState(
            AnnouncementLoadedStateWithoutAnnouncements(
                announcements: announcementsAssociation));
      } else {
        this.announcements = announcements!;
        BlocProvider.of<AnnouncementCubit>(context).changeState(
            AnnouncementLoadedState(announcements: this.announcements));
      }
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
            idAssociation: widget.idAssociation,
            onAnnouncementsChanged: _handleAnnouncementFilterChanged),
      ),
      body: BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementLoadedState) {
              announcements = state.announcements
                  .where((element) => element.isVisible ?? true)
                  .toList();
          } else if (state is AnnouncementLoadedStateWithoutAnnouncements) {
            if (widget.idAssociation != null && widget.idAssociation != '') {
                announcementsAssociation = state.announcements;
            }
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
          if (state is AnnouncementLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AnnouncementErrorState) {
            return Center(child: Text(state.message));
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
          if (state is AnnouncementLoadedState) {
            announcements = state.announcements
                .where((element) => element.isVisible ?? true)
                .toList();
          }
          if (state is AnnouncementLoadedStateWithoutAnnouncements) {
            if (_searchQuery.isNotEmpty && _searchQuery != '') {
              announcementsAssociation = state.announcements
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
              announcementsAssociation = state.announcements;
            }
          }

          return FutureBuilder<List<Announcement>>(
            future: _processAnnouncements(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
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

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _reloadData() async {
    print(widget.rulesType);
    if (widget.rulesType == RulesType.USER_ASSOCIATION) {
      String idAssociation = widget.idAssociation!;
      BlocProvider.of<AnnouncementCubit>(context)
          .getAllAnnouncementByAssociation(idAssociation);
    } else {
      BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
    }
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    if (announcements.isEmpty) {
      return _buildEmptyList();
    }
    if (widget.rulesType == RulesType.USER_ASSOCIATION) {
      return _buildListViewAnnouncementsAssociation(announcements);
    }
    return _buildListViewAnnouncementsVolunteer(announcements);
  }

  Widget _buildListViewAnnouncementsAssociation(
      List<Announcement> announcements) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (widget.rulesType == RulesType.USER_ASSOCIATION) {
            int reversedIndex = announcements.length - index - 1;
            return ItemAnnouncementAssociation(
                announcement: announcements[reversedIndex],
                nbAnnouncementsAssociation: announcements.length);
          }
        },
        itemCount: announcements.length,
      ),
    );
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
              if (widget.rulesType == RulesType.USER_ASSOCIATION) {
                String idAssociation = widget.idAssociation!;
                BlocProvider.of<AnnouncementCubit>(context)
                    .getAllAnnouncementByAssociation(idAssociation);
              } else {
                BlocProvider.of<AnnouncementCubit>(context)
                    .getAllAnnouncements();
              }
            },
            child: Text('Recharger'),
          ),
        ],
      ),
    );
  }
}

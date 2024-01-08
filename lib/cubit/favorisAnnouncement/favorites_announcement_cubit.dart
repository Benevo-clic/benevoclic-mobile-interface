import 'package:bloc/bloc.dart';

import '../../repositories/api/favorites_repository.dart';
import 'favorites_announcement_state.dart';

class FavoritesAnnouncementCubit extends Cubit<FavoritesAnnouncementState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesAnnouncementCubit({required FavoritesRepository favoritesRepository})
      : _favoritesRepository = favoritesRepository,
        super(FavoritesAnnouncementInitialState());

  void addFavoritesAnnouncement(
    String? id,
    String idAnnouncement,
  ) async {
    emit(FavoritesAnnouncementLoadingState());
    try {
      await _favoritesRepository.addFavorites(id!, idAnnouncement);

      emit(FavoritesAnnouncementAddingState(idAnnouncement: idAnnouncement));
    } catch (e) {
      emit(FavoritesAnnouncementErrorState(message: e.toString()));
    }
  }

  void removeFavoritesAnnouncement(
      String? idVolunteer, String idAnnouncement) async {
    emit(FavoritesAnnouncementLoadingState());
    try {
      await _favoritesRepository.deleteFavorites(idVolunteer!, idAnnouncement);
      emit(FavoritesAnnouncementRemovingState(idAnnouncement: idAnnouncement));
    } catch (e) {
      emit(FavoritesAnnouncementErrorState(message: e.toString()));
    }
  }

  void getFavoritesAnnouncementByVolunteerId(String idVolunteer) async {
    emit(FavoritesAnnouncementLoadingState());
    try {
      var favoritesAnnouncement = await _favoritesRepository
          .getFavoritesAnnouncementByVolunteerId(idVolunteer);

      emit(FavoritesAnnouncementLoadedState(
          favoritesAnnouncement: favoritesAnnouncement));
    } catch (e) {
      emit(FavoritesAnnouncementErrorState(message: e.toString()));
    }
  }
}

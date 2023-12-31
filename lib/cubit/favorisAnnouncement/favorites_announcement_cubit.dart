import 'package:bloc/bloc.dart';

import '../../repositories/api/favorites_repository.dart';
import 'favorites_announcement_state.dart';

class FavoritesAnnouncementCubit extends Cubit<FavoritesAnnouncementState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesAnnouncementCubit({required FavoritesRepository favoritesRepository})
      : _favoritesRepository = favoritesRepository,
        super(FavoritesAnnouncementInitialState());

  void selectOption(String value) {
    emit(value as FavoritesAnnouncementState);
  }

  void setFavoritesAnnouncementAdding(String idAnnouncement) {
    var currentState = state;
    if (currentState is FavoritesAnnouncementAddingState &&
        currentState.idAnnouncement == idAnnouncement &&
        currentState.isAdding == true) {
      return;
    }
    emit(FavoritesAnnouncementAddingState(
        idAnnouncement: idAnnouncement, isAdding: true));
  }

  void setFavoritesAnnouncementRemoving(String idAnnouncement) {
    var currentState = state;
    if (currentState is FavoritesAnnouncementRemovingState &&
        currentState.idAnnouncement == idAnnouncement &&
        currentState.isRemoving == true) {
      return;
    }
    emit(FavoritesAnnouncementRemovingState(
        idAnnouncement: idAnnouncement, isRemoving: true));
  }

  void setFavoritesAnnouncement(String idAnnouncement) {
    var currentState = state;
    if (currentState is FavoritesAnnouncementRemovingState &&
        currentState.idAnnouncement == idAnnouncement &&
        currentState.isRemoving == true) {
      return;
    }
    emit(FavoritesAnnouncementAddingState(
        idAnnouncement: idAnnouncement, isAdding: true));
  }

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

  void isFavorite(String? idVolunteer, String idAnnouncement) async {
    emit(FavoritesAnnouncementLoadingState());
    Future.delayed(Duration(seconds: 2));
    try {
      var isFavorite =
          await _favoritesRepository.isFavorite(idVolunteer!, idAnnouncement);
      emit(FavoritesAnnouncementIsFavoriteState(isFavorite: isFavorite));
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
      print(e.toString());
      emit(FavoritesAnnouncementErrorState(message: e.toString()));
    }
  }
}

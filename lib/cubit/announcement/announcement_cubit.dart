import 'package:bloc/bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/repositories/api/Announcement_repository.dart';

import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final AnnouncementRepository _announcementRepository;

  AnnouncementCubit({required AnnouncementRepository announcementRepository})
      : _announcementRepository = announcementRepository,
        super(AnnouncementInitialState());

  void selectOption(String value) {
    emit(value as AnnouncementState);
  }

  void setAnnouncement(Announcement announcement) {
    emit(AnnouncementSelectedState(
        announcements: [], announcement: announcement));
  }

  void setAnnouncementUpdating(Announcement announcement) {
    var currentState = state;
    if (currentState is AnnouncementUpdatingState &&
        currentState.announcement == announcement &&
        currentState.isUpdating == true) {
      return;
    }
    emit(AnnouncementUpdatingState(
        announcement: announcement, isUpdating: true));
  }

  void hiddenAnnouncement(String id, bool isVisible) async {
    emit(AnnouncementLoadingState());
    try {
      Announcement announcementUpdated =
          await _announcementRepository.hiddenAnnouncement(id, isVisible);
      emit(HideAnnouncementState(
          announcement: announcementUpdated, isVisible: isVisible));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void updateAnnouncement(String id, Announcement announcement) async {
    emit(AnnouncementLoadingState());
    try {
      Announcement announcementUpdated =
          await _announcementRepository.updateAnnouncement(id, announcement);
      emit(AnnouncementCreatedState(announcement: announcementUpdated));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void selectAnnouncementType(String type) {
    if (type == 'Autre') {
      emit(CustomAnnouncementTypeState(""));
    } else {
      emit(AnnouncementInitialState());
    }
  }

  void createAnnouncement(Announcement announcement) async {
    if (state is AnnouncementCreatedState) {
      return;
    }

    emit(AnnouncementLoadingState());
    try {
      Announcement announcementCreated =
          await _announcementRepository.createAnnouncement(announcement);
      emit(AnnouncementCreatedState(announcement: announcementCreated));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void getAllAnnouncementByAssociation(String idAssociation) async {
    emit(AnnouncementLoadingState());

    try {
      List<Announcement> announcements = await _announcementRepository
          .getAnnouncementByAssociation(idAssociation);
      emit(AnnouncementLoadedStateWithoutAnnouncements(
          announcements: announcements));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void deleteAnnouncement(String id) async {
    if (state is DeleteAnnouncementState) {
      return;
    }

    emit(AnnouncementLoadingState());
    try {
      Announcement announcement =
          await _announcementRepository.deleteOneAnnouncement(id);
      emit(DeleteAnnouncementState(announcement: announcement));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void getAllAnnouncements() async {
    emit(AnnouncementLoadingState());
    try {
      List<Announcement> announcements =
          await _announcementRepository.getAnnouncements();
      emit(AnnouncementLoadedState(announcements: announcements));
    } catch (e) {
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void changeState(AnnouncementState state) {
    emit(state);
  }
}

import 'package:bloc/bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/association_model.dart';
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

  void selectAnnouncementType(String type) {
    if (type == 'Autre') {
      emit(CustomAnnouncementTypeState(""));
    } else {
      emit(AnnouncementInitialState());
    }
  }

  void createAnnouncement(Announcement announcement) async {
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
      Association association =
          await _announcementRepository.getAssociationById(idAssociation);
      emit(AnnouncementLoadedStateWithoutAnnouncements(
          association: association));
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

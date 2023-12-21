import 'package:bloc/bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/repositories/api/Announcement_repository.dart';

import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final AnnouncementRepository _announcementRepository;

  AnnouncementCubit({required AnnouncementRepository announcementRepository})
      : _announcementRepository = announcementRepository,
        super(AnnouncementInitialState());
  getAllAnnouncement() async {
    emit(AnnouncementLoadingState());
    await Future.delayed(const Duration(seconds: 2));
  }

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
    Future.delayed(const Duration(seconds: 2));
    try {
      Announcement announcementCreated =
          await _announcementRepository.createAnnouncement(announcement);
      print("Announcement created");
      emit(AnnouncementCreatedState(announcement: announcementCreated));
    } catch (e) {
      print(e.toString());
      emit(AnnouncementErrorState(message: e.toString()));
    }
  }

  void changeState(AnnouncementState state) {
    emit(state);
  }
}

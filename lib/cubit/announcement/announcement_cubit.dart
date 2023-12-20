import 'package:bloc/bloc.dart';

import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementInitialState());

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
}

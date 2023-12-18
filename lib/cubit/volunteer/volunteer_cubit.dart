import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';

import '../../models/volunteer_model.dart';
import '../../repositories/api/volunteer_repository.dart';

class VolunteerCubit extends Cubit<VolunteerState> {
  final VolunteerRepository _volunteerRepository;

  VolunteerCubit({required VolunteerRepository volunteerRepository})
      : _volunteerRepository = volunteerRepository,
        super(VolunteerInitialState());

  void initState() {
    emit(VolunteerInitialState());
  }

  void changeState(VolunteerState state) {
    emit(state);
  }

  Future<void> createVolunteer(Volunteer volunteer) async {
    emit(VolunteerLoadingState());
    print("create volunteer in cubit");
    try {
      print(volunteer.toJson());
      final result = await _volunteerRepository.createVolunteer(volunteer);
      print("++++++++++++++++++++++++cubit+++++++++++" + result.firstName);
      emit(VolunteerCreatedState(volunteerModel: volunteer));
    } catch (e) {
      print("+++++++++++++++++++++++++++++++++++++" + e.toString());
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<void> getVolunteer(String email) async {
    emit(VolunteerLoadingState());
    print("create volunteer in cubit");
    try {
      final result = await _volunteerRepository.get(email);
      print(result);
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }
}

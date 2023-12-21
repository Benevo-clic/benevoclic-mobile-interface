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
    try {
      await _volunteerRepository.createVolunteer(volunteer);
      emit(VolunteerCreatedState(volunteerModel: volunteer));
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<Volunteer> getVolunteer(String id) async {
    //emit(VolunteerLoadingState());

    Volunteer volunteer = await _volunteerRepository.getVolunteer(id);
    return volunteer;
  }

  Future<void> volunteerState(Volunteer volunteer)async{
    emit(VolunteerInfo(volunteer: volunteer));
  }
}

import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';

import '../../repositories/api/volunteer_repository.dart';

class VolunteerCubit extends Cubit<VolunteerState> {
  final VolunteerRepository _volunteerRepository;

  VolunteerCubit({required VolunteerRepository volunteerRepository})
      : _volunteerRepository = volunteerRepository,
        super(VolunteerInitialState());

  void initState() {
    emit(VolunteerInitialState());
  }
}

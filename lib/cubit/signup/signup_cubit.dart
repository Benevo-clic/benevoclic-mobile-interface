import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/signup/signup_state.dart';

import '../../models/association_model.dart';
import '../../models/volunteer_model.dart';
import '../../repositories/api/association_repository.dart';
import '../../repositories/api/volunteer_repository.dart';

class SignupCubit extends Cubit<SignupState> {
  final AssociationRepository _associationRepository;
  final VolunteerRepository _volunteerRepository;

  SignupCubit(
      {required VolunteerRepository volunteerRepository,
      required AssociationRepository associationRepository})
      : _associationRepository = associationRepository,
        _volunteerRepository = volunteerRepository,
        super(SignupInitialState());

  void initState() {
    emit(SignupInitialState());
  }

  void changeState(SignupState state) {
    emit(state);
  }

  Future<void> createVolunteer(Volunteer volunteer) async {
    emit(SignupLoadingState());
    try {
      await _volunteerRepository.createVolunteer(volunteer);
      emit(SignupCreatedVolunteerState(volunteerModel: volunteer));
    } catch (e) {
      emit(SignupErrorState(message: e.toString()));
    }
  }

  Future<void> createAssociation(Association association) async {
    emit(SignupLoadingState());
    try {
      await _associationRepository.createAssociation(association);
      emit(SignupCreatedAssociationState(associationModel: association));
    } catch (e) {
      emit(SignupErrorState(message: e.toString()));
    }
  }
}

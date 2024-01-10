import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/association_model.dart';

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

  Future<void> unfollowAssociation(String id) async {
    emit(VolunteerLoadingState());
    try {
      Association association =
          await _volunteerRepository.unfollowAssociation(id);
      emit(VolunteerUnFollowAssociationState(association: association));
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<void> followAssociation(String id) async {
    emit(VolunteerLoadingState());
    try {
      Association association =
          await _volunteerRepository.followAssociation(id);
      emit(VolunteerFollowAssociationState(association: association));
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<void> getVolunteer(String? id) async {
    emit(VolunteerLoadingState());
    try {
      Volunteer volunteer = await _volunteerRepository.getVolunteer(id!);
      emit(VolunteerInfo(volunteer: volunteer));
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<void> updateVolunteer(Volunteer volunteerOld) async {
    emit(VolunteerLoadingState());
    try {
      Volunteer volunteerNew = await _volunteerRepository.updateVolunteer(volunteerOld);
      emit(VolunteerUpdateState(volunteerModel: volunteerNew));
    } catch (e) {
      emit(VolunteerErrorState(message: e.toString()));
    }
  }

  Future<void> volunteerState(Volunteer volunteer) async {
    emit(VolunteerInfo(volunteer: volunteer));
  }

  Future<void> deleteVolunteer() async {
    await _volunteerRepository.deleteVolunteer();
  }

}

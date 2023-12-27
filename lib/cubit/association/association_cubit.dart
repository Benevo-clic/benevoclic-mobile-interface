import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart';

import '../../models/association_model.dart';
import '../../repositories/api/association_repository.dart';
import 'association_state.dart';
import 'package:namer_app/util/globals.dart' as globals;

class AssociationCubit extends Cubit<AssociationState> {
  final AssociationRepository _associationRepository;

  AssociationCubit({required AssociationRepository associationRepository})
      : _associationRepository = associationRepository,
        super(AssociationInitialState());

  void initState() {
    emit(AssociationInitialState());
  }

  void changeState(AssociationState state) {
    if (state is AssociationInitialState) {
      return;
    }
    if (state is AssociationLoadingState) {
      return;
    }
    if (state is AssociationErrorState) {
      return;
    }
    if (state is AssociationCreatedState) {
      return;
    }

    emit(state);
  }

  Future<void> createAssociation(Association association) async {
    if (state is AssociationCreatedState) {
      return;
    }

    emit(AssociationLoadingState());
    try {
      await _associationRepository.createAssociation(association);
      emit(AssociationCreatedState(associationModel: association));
    } catch (e) {
      emit(AssociationErrorState(message: e.toString()));
    }
  }

  Future<Association> getAssociation(String id) async {
    Association association = await _associationRepository.getAssociation(id);
    return association;
  }

  Future<void> updateAssociation(Association association) async {
    await _associationRepository.updateAssociation(association);
  }
}

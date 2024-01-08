import 'package:bloc/bloc.dart';

import '../../models/association_model.dart';
import '../../repositories/api/association_repository.dart';
import 'association_state.dart';

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

  void stateInfo(Association association) {
    emit(AssociationConnexion(association));
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

  Future<void> getAssociation(String id) async {
    emit(AssociationLoadingState());
    try {
      Association association = await _associationRepository.getAssociation(id);
      emit(AssociationConnexion(association));
    } catch (e) {
      emit(AssociationErrorState(message: e.toString()));
    }
  }

  Future<void> updateAssociation(Association association) async {
    await _associationRepository.updateAssociation(association);
  }

  Future<void> deleteAccount() async {
    await _associationRepository.deleteAssociation();
  }
}

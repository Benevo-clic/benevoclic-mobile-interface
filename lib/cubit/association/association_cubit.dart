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
    emit(state);
  }

  Future<void> createAssociation(Association association) async {
    emit(AssociationLoadingState());
    try {
      await _associationRepository.createAssociation(association);
      emit(AssociationCreatedState(associationModel: association));
    } catch (e) {
      emit(AssociationErrorState(message: e.toString()));
    }
  }
}

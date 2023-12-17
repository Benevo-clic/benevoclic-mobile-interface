import 'package:bloc/bloc.dart';

import '../../models/association_model.dart';
import '../../repositories/api/association_repository.dart';
import 'association_state.dart';

class AssociationCubit extends Cubit<AssociationState> {
  final AssociationRepository _associationRepository;

  AssociationCubit(this._associationRepository)
      : super(AssociationInitialState());

  void initState() {
    emit(AssociationInitialState());
  }

  void changeState(AssociationState state) {
    emit(state);
  }

  Future<void> verifySiretAssociation(String siret) async {
    emit(AssociationLoadingState());
    try {
      await _associationRepository.verifySiretAssocition(siret);
      emit(AssociationVerifyState());
    } catch (e) {
      emit(AssociationVerifyErrorState());
    }
  }

  Future<void> createAssociation(Association association) async {
    emit(AssociationLoadingState());
    try {
      final result =
          await _associationRepository.createAssociation(association);
      emit(AssociationCreatedState(associationModel: result));
    } catch (e) {
      emit(AssociationErrorState(message: e.toString()));
    }
  }
}

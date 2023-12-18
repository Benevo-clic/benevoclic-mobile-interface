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

  // Future<void> verifySiretAssociation(String siret) async {
  //   emit(AssociationLoadingState());
  //   try {
  //     Future.delayed(const Duration(seconds: 3));
  //     bool verify = await _associationRepository.verifySiretAssociation(siret);
  //     print(verify);
  //     emit(AssociationVerifyState(isVerified: verify));
  //   } catch (e) {
  //     emit(AssociationVerifyErrorState());
  //   }
  // }

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

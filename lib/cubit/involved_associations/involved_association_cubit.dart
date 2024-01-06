import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/involved_associations/involved_association_state.dart';
import 'package:namer_app/models/association_model.dart';

class InvolvedAssociationCubit extends Cubit<InvolvedAssociationState> {
  InvolvedAssociationCubit()
      : super(InvolvedAssociationAcceptedState(associations: [
          Association(name: "name", phone: "phone", type: "type"),
          Association(name: "name", phone: "phone", type: "type")
        ]));

  void initState(String id) {
    List<Association> associations = [
      Association(name: "name", phone: "phone", type: "type"),
          Association(name: "name", phone: "phone", type: "type")
    ];

    emit(InvolvedAssociationAcceptedState(associations: associations));
  }

  void detail(String id) {
    emit(InvolvedAssociationLoadingState());
    Association association =
        Association(name: "name", phone: "phone", type: "type");
    emit(InvolvedAssociationDetailState(association: association));
  }

  void allAnnouncements(String id) {
    emit(InvolvedAssociationLoadingState());
    Association association =
        Association(name: "name", phone: "phone", type: "type");
    ;
    emit(InvolvedAssociationDetailState(association: association));
  }
}

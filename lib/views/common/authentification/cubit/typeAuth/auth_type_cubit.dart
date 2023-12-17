import 'package:bloc/bloc.dart';

import 'auth_type_state.dart';

class AuthTypeCubit extends Cubit<AuthTypeState> {
  AuthTypeCubit() : super(AuthTypeInitialState());

  void loginAsAssociation() {
    emit(AssociationLoginState());
  }

  void loginAsVolunteer() {
    emit(VolunteerLoginState());
  }

  void inscription() {
    emit(InscriptionState());
  }
}

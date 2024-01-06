import 'package:bloc/bloc.dart';
import 'package:namer_app/cubit/members/members_state.dart';
import 'package:namer_app/models/volunteer_model.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit()
      : super(MembersAcceptedState(volunteers: [
          Volunteer(
              firstName: "firstName",
              lastName: "lastName",
              phone: "phone",
              birthDayDate: "irthDayDate"),
          Volunteer(
              firstName: "GEo",
              lastName: "lastName",
              phone: "phone",
              birthDayDate: "irthDayDate")
        ]));

  void initState(String id) {
    List<Volunteer> volunteers = [
      Volunteer(
          firstName: "firstName",
          lastName: "lastName",
          phone: "phone",
          birthDayDate: "irthDayDate"),
      Volunteer(
          firstName: "GEo",
          lastName: "lastName",
          phone: "phone",
          birthDayDate: "irthDayDate")
    ];

    emit(MembersAcceptedState(volunteers: volunteers));
  }

  void detail(String id) {
    emit(MembersLoadingState());
    Volunteer volunteer = Volunteer(
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        birthDayDate: "birthDayDate");
    emit(MembersDetailState(volunteer: volunteer));
  }

  void membersToAccept(String id) {
    emit(MembersLoadingState());

    List<Volunteer> volunteers = [
      Volunteer(
          firstName: "firstName",
          lastName: "lastName",
          phone: "phone",
          birthDayDate: "irthDayDate"),
      Volunteer(
          firstName: "GEo",
          lastName: "lastName",
          phone: "phone",
          birthDayDate: "irthDayDate")
    ];

    emit(MembersToAcceptState(volunteers: volunteers));
  }
}

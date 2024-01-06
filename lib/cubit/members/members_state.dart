import 'package:flutter/material.dart';
import 'package:namer_app/models/volunteer_model.dart';

@immutable
abstract class MembersState {
  List<Volunteer>? volunteers;
}

class MembersAcceptedState extends MembersState {
  final List<Volunteer> volunteers;

  MembersAcceptedState({required this.volunteers});
}

class MembersLoadingState extends MembersState {}

class MembersToAcceptState extends MembersState {
  final List<Volunteer> volunteers;

  MembersToAcceptState({required this.volunteers});
}

class MembersDetailState extends MembersState {
  final Volunteer volunteer;

  MembersDetailState({required this.volunteer});
}



import 'package:flutter/material.dart';

import '../../models/announcement_model.dart';

@immutable
abstract class AnnouncementState {
}

class AnnouncementInitialState extends AnnouncementState {
}

class AnnouncementLoadingState extends AnnouncementState {
}

class AnnouncementLoadedState extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementLoadedState({required this.announcements});
}

class AnnouncementSelectedState extends AnnouncementLoadedState {
  final Announcement announcement;

  AnnouncementSelectedState(
      {required super.announcements, required this.announcement});
}

class AnnouncementErrorState extends AnnouncementState {
  final String message;

  AnnouncementErrorState({required this.message});
}

class AnnouncementEmptyState extends AnnouncementState {
  final String message;

  AnnouncementEmptyState({required this.message});
}

class AnnouncementWaitingState extends AnnouncementState {
  final String message;

  AnnouncementWaitingState({required this.message});
}



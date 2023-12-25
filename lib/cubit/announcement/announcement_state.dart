import 'dart:typed_data';

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

class DeleteAnnouncementState extends AnnouncementState {
  final Announcement announcement;

  DeleteAnnouncementState({required this.announcement});
}

class AnnouncementLoadedStateWithoutAnnouncements extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementLoadedStateWithoutAnnouncements({required this.announcements});
}

class AnnouncementUploadedPictureState extends AnnouncementState {
  final Uint8List? image;

  AnnouncementUploadedPictureState({required this.image});
}

class AnnouncementCreatedState extends AnnouncementState {
  final Announcement announcement;

  AnnouncementCreatedState({required this.announcement});
}

class AnnouncementSelectedState extends AnnouncementLoadedState {
  final Announcement announcement;

  AnnouncementSelectedState(
      {required super.announcements, required this.announcement});
}

class CustomAnnouncementTypeState extends AnnouncementState {
  final String customType;

  CustomAnnouncementTypeState(this.customType);
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



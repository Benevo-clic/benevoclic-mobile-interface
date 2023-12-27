import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/announcement_model.dart';

@immutable
abstract class AnnouncementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnnouncementInitialState extends AnnouncementState {}

class AnnouncementLoadingState extends AnnouncementState {
}

class AnnouncementUpdatingState extends AnnouncementState {
  final Announcement announcement;
  final bool? isUpdating;

  AnnouncementUpdatingState(
      {required this.isUpdating, required this.announcement});
}

class AnnouncementLoadedState extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementLoadedState({required this.announcements});

  @override
  List<Object?> get props => [announcements];
}

class DeleteAnnouncementState extends AnnouncementState {
  final Announcement announcement;

  DeleteAnnouncementState({required this.announcement});

  @override
  List<Object?> get props => [announcement];
}

class AnnouncementLoadedStateWithoutAnnouncements extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementLoadedStateWithoutAnnouncements({required this.announcements});

  @override
  List<Object?> get props => [announcements];
}

class AnnouncementUploadedPictureState extends AnnouncementState {
  final Uint8List? image;

  AnnouncementUploadedPictureState({required this.image});

  @override
  List<Object?> get props => [image];
}

class AnnouncementCreatedState extends AnnouncementState {
  final Announcement announcement;

  AnnouncementCreatedState({required this.announcement});

  @override
  List<Object?> get props => [announcement];
}

class HideAnnouncementState extends AnnouncementState {
  final Announcement announcement;
  bool isVisible = false;

  HideAnnouncementState({required this.announcement, this.isVisible = false});

  @override
  List<Object?> get props => [announcement];
}

class AnnouncementSelectedState extends AnnouncementLoadedState {
  final Announcement announcement;

  AnnouncementSelectedState(
      {required super.announcements, required this.announcement});

  @override
  List<Object?> get props => [announcement];
}

class CustomAnnouncementTypeState extends AnnouncementState {
  final String customType;

  CustomAnnouncementTypeState(this.customType);

  @override
  List<Object?> get props => [customType];
}

class UpdateAnnouncementState extends AnnouncementState {
  final Announcement announcement;
  final String id;

  UpdateAnnouncementState({required this.id, required this.announcement});

  @override
  List<Object?> get props => [announcement, id];
}

class AnnouncementErrorState extends AnnouncementState {
  final String message;

  AnnouncementErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AnnouncementEmptyState extends AnnouncementState {
  final String message;

  AnnouncementEmptyState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AnnouncementWaitingState extends AnnouncementState {
  final String message;

  AnnouncementWaitingState({required this.message});

  @override
  List<Object?> get props => [message];
}



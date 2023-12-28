import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/favorites_model.dart';

@immutable
abstract class FavoritesAnnouncementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesAnnouncementInitialState extends FavoritesAnnouncementState {}

class FavoritesAnnouncementLoadingState extends FavoritesAnnouncementState {}

class FavoritesAnnouncementAddingState extends FavoritesAnnouncementState {
  final String idAnnouncement;
  final bool? isAdding;

  FavoritesAnnouncementAddingState(
      {this.isAdding, required this.idAnnouncement});

  @override
  List<Object?> get props => [isAdding, idAnnouncement];
}

class FavoritesAnnouncementLoadedState extends FavoritesAnnouncementState {
  final Favorites favoritesAnnouncement;

  FavoritesAnnouncementLoadedState({required this.favoritesAnnouncement});

  @override
  List<Object?> get props => [favoritesAnnouncement];
}

class FavoritesAnnouncementIsFavoriteState extends FavoritesAnnouncementState {
  final bool? isFavorite;

  FavoritesAnnouncementIsFavoriteState({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}

class FavoritesAnnouncementErrorState extends FavoritesAnnouncementState {
  final String message;

  FavoritesAnnouncementErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class FavoritesAnnouncementRemovingState extends FavoritesAnnouncementState {
  final String idAnnouncement;
  final bool? isRemoving;

  FavoritesAnnouncementRemovingState(
      {this.isRemoving, required this.idAnnouncement});

  @override
  List<Object?> get props => [isRemoving, idAnnouncement];
}

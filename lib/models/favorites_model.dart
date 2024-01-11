import 'package:json_annotation/json_annotation.dart';

import 'announcement_item_model.dart';
import 'announcement_model.dart';

part 'favorites_model.g.dart';

@JsonSerializable()
class Favorites {

  @JsonKey(name: 'idVolunteer')
  final String idVolunteer;

  @JsonKey(name: 'announcementFavorites')
  final List<Announcement> announcementFavorites;

  Favorites({
    required this.idVolunteer,
    required this.announcementFavorites,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) =>
      _$FavoritesFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesToJson(this);
}
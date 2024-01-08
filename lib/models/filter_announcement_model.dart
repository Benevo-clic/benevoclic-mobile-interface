import 'package:json_annotation/json_annotation.dart';

part 'filter_announcement_model.g.dart';

@JsonSerializable()
class FilterAnnouncement {
  String? sortBy;
  int? hours;
  String? startDate;
  String? endDate;
  List<dynamic>? timeOfDay;
  double? userLatitude;
  double? userLongitude;
  double? maxDistance;

  FilterAnnouncement({
    this.sortBy,
    this.hours,
    this.startDate,
    this.endDate,
    this.timeOfDay,
    this.userLatitude,
    this.userLongitude,
    this.maxDistance,
  });

  factory FilterAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$FilterAnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAnnouncementToJson(this);
}

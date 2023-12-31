import 'package:json_annotation/json_annotation.dart';

part 'announcement_item_model.g.dart';

@JsonSerializable()
class AnnouncementItem {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'nameEvent')
  late final String labelEvent;


  AnnouncementItem({
    this.id,
    required this.labelEvent,
  });

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementItemToJson(this);

  AnnouncementItem copyWith({
    String? id,
    String? labelEvent,
  }) {
    return AnnouncementItem(
      id: id ?? this.id,
      labelEvent: labelEvent ?? this.labelEvent,
    );
  }
}

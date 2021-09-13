import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_item.g.dart';

@JsonSerializable()
class RestaurantItem extends Equatable {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'pictureId')
  final String? pictureId;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'rating')
  final double? rating;

  RestaurantItem({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
      ];

  factory RestaurantItem.fromJson(Map<String, dynamic> json) =>
      _$RestaurantItemFromJson(json);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating
  };
}

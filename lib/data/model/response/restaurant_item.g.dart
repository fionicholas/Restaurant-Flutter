// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantItem _$RestaurantItemFromJson(Map<String, dynamic> json) {
  return RestaurantItem(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    pictureId: json['pictureId'] as String?,
    city: json['city'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$RestaurantItemToJson(RestaurantItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'rating': instance.rating,
    };

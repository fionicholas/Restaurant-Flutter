// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRestaurantResponse _$SearchRestaurantResponseFromJson(
    Map<String, dynamic> json) {
  return SearchRestaurantResponse(
    error: json['error'] as bool?,
    founded: json['founded'] as int?,
    restaurants: (json['restaurants'] as List<dynamic>)
        .map((e) => RestaurantItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SearchRestaurantResponseToJson(
        SearchRestaurantResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'founded': instance.founded,
      'restaurants': instance.restaurants,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailRestaurantResponse _$DetailRestaurantResponseFromJson(
    Map<String, dynamic> json) {
  return DetailRestaurantResponse(
    error: json['error'] as bool?,
    message: json['message'] as String?,
    restaurant: DetailRestaurantItem.fromJson(
        json['restaurant'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailRestaurantResponseToJson(
        DetailRestaurantResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'restaurant': instance.restaurant,
    };

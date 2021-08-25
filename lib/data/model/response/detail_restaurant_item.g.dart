// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_restaurant_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailRestaurantItem _$DetailRestaurantItemFromJson(Map<String, dynamic> json) {
  return DetailRestaurantItem(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    pictureId: json['pictureId'] as String?,
    city: json['city'] as String?,
    address: json['address'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
    menuResponse: MenuResponse.fromJson(json['menus'] as Map<String, dynamic>),
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => SharedNameItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    customerReviews: (json['customerReviews'] as List<dynamic>?)
        ?.map((e) => CustomerReviewsItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DetailRestaurantItemToJson(
        DetailRestaurantItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'address': instance.address,
      'categories': instance.categories,
      'customerReviews': instance.customerReviews,
      'rating': instance.rating,
      'menus': instance.menuResponse,
    };

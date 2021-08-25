// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_reviews_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerReviewsItem _$CustomerReviewsItemFromJson(Map<String, dynamic> json) {
  return CustomerReviewsItem(
    name: json['name'] as String?,
    review: json['review'] as String?,
    date: json['date'] as String?,
  );
}

Map<String, dynamic> _$CustomerReviewsItemToJson(
        CustomerReviewsItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'review': instance.review,
      'date': instance.date,
    };

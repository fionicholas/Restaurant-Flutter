// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerReviewRequest _$CustomerReviewRequestFromJson(
    Map<String, dynamic> json) {
  return CustomerReviewRequest(
    name: json['name'] as String,
    review: json['review'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$CustomerReviewRequestToJson(
        CustomerReviewRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'review': instance.review,
      'id': instance.id,
    };

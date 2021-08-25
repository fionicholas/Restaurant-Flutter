// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_customer_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCustomerReviewsResponse _$AddCustomerReviewsResponseFromJson(
    Map<String, dynamic> json) {
  return AddCustomerReviewsResponse(
    error: json['error'] as bool?,
    message: json['message'] as String?,
    customerReviews: (json['customerReviews'] as List<dynamic>?)
        ?.map((e) => CustomerReviewsItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AddCustomerReviewsResponseToJson(
        AddCustomerReviewsResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'customerReviews': instance.customerReviews,
    };

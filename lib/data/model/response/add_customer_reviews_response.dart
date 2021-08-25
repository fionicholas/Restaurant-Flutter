import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer_reviews_item.dart';

part 'add_customer_reviews_response.g.dart';

@JsonSerializable()
class AddCustomerReviewsResponse extends Equatable {
  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'customerReviews')
  final List<CustomerReviewsItem>? customerReviews;

  AddCustomerReviewsResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  @override
  List<Object?> get props => [
        error,
        message,
        customerReviews,
      ];

  factory AddCustomerReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCustomerReviewsResponseFromJson(json);
}

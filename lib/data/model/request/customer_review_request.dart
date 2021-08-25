import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_review_request.g.dart';

@JsonSerializable()
class CustomerReviewRequest extends Equatable {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'review')
  final String review;

  @JsonKey(name: 'id')
  final String id;

  CustomerReviewRequest({
    required this.name,
    required this.review,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        review,
        id,
      ];

  factory CustomerReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReviewRequestToJson(this);
}

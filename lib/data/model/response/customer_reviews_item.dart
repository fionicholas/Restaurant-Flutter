import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_reviews_item.g.dart';

@JsonSerializable()
class CustomerReviewsItem extends Equatable {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'review')
  final String? review;

  @JsonKey(name: 'date')
  final String? date;

  CustomerReviewsItem({this.name, this.review, this.date});

  @override
  List<Object?> get props => [
        name,
        review,
        date,
      ];

  factory CustomerReviewsItem.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewsItemFromJson(json);
}

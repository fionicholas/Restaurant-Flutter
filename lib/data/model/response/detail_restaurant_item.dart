import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/response/customer_reviews_item.dart';
import 'package:restaurant_app/data/model/response/shared_name_item.dart';
import 'package:restaurant_app/data/model/response/menu_response.dart';

part 'detail_restaurant_item.g.dart';

@JsonSerializable()
class DetailRestaurantItem extends Equatable {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'pictureId')
  final String? pictureId;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'categories')
  final List<SharedNameItem>? categories;

  @JsonKey(name: 'customerReviews')
  final List<CustomerReviewsItem>? customerReviews;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'menus')
  final MenuResponse menuResponse;

  DetailRestaurantItem(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.address,
      this.rating,
      required this.menuResponse,
      this.categories,
      this.customerReviews});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        address,
        rating,
        menuResponse,
        categories,
        customerReviews,
      ];

  factory DetailRestaurantItem.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantItemFromJson(json);
}

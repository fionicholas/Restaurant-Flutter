import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';

part 'search_restaurant_response.g.dart';

@JsonSerializable()
class SearchRestaurantResponse extends Equatable {
  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'founded')
  final int? founded;

  @JsonKey(name: 'restaurants')
  final List<RestaurantItem> restaurants;

  SearchRestaurantResponse({
    this.error,
    this.founded,
    required this.restaurants,
  });

  @override
  List<Object?> get props => [
        error,
        founded,
        restaurants,
      ];

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRestaurantResponseFromJson(json);
}

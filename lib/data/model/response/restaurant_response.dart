import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';

part 'restaurant_response.g.dart';

@JsonSerializable()
class RestaurantResponse extends Equatable {
  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'restaurants')
  final List<RestaurantItem> restaurants;

  RestaurantResponse({
    this.error,
    this.message,
    this.count,
    required this.restaurants,
  });

  @override
  List<Object?> get props => [
        error,
        message,
        count,
        restaurants,
      ];

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

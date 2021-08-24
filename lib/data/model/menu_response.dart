import 'package:restaurant_app/data/model/menu_item.dart';

class MenuResponse {
  MenuResponse({
    required this.foods,
    required this.drinks,
  });

  List<MenuItem> foods;
  List<MenuItem> drinks;

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        foods:
            List<MenuItem>.from(json["foods"].map((x) => MenuItem.fromJson(x))),
        drinks: List<MenuItem>.from(
            json["drinks"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

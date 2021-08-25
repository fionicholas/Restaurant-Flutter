import 'package:restaurant_app/bloc/model/shared_name.dart';

class Menu {
  final List<SharedName> foods;

  final List<SharedName> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });
}

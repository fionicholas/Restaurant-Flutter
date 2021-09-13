import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/restaurant/model/detail_restaurant.dart';
import 'package:restaurant_app/ui/shared/custom_menus_card.dart';
import 'package:restaurant_app/utils/assets.dart';

class ContainerDrinks extends StatelessWidget {
  final DetailRestaurant detailRestaurant;

  const ContainerDrinks({Key? key, required this.detailRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3.2,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: detailRestaurant.menu.drinks.length,
          itemBuilder: (context, index) {
            return CustomMenusCard(
                image: DRINKS_ICON,
                name: detailRestaurant.menu.drinks[index].name);
          }),
    );
  }
}

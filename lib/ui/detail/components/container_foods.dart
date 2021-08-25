import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/model/detail_restaurant.dart';
import 'package:restaurant_app/ui/shared/custom_menus_card.dart';

class ContainerFoods extends StatelessWidget {
  final DetailRestaurant detailRestaurant;

  const ContainerFoods({Key? key, required this.detailRestaurant})
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
          itemCount: detailRestaurant.menu.foods.length,
          itemBuilder: (context, index) {
            return CustomMenusCard(
                image: 'assets/images/ic_foods.jpg',
                name: detailRestaurant.menu.foods[index].name);
          }),
    );
  }
}

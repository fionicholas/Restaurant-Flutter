import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/restaurant/model/detail_restaurant.dart';
import 'package:restaurant_app/ui/shared/custom_reviews_card.dart';

class ContainerCustomerReviews extends StatelessWidget {
  final DetailRestaurant detailRestaurant;

  const ContainerCustomerReviews({Key? key, required this.detailRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: detailRestaurant.customerReviews.length,
          itemBuilder: (context, index) {
            return CustomReviewsCard(
              customerReviews: detailRestaurant.customerReviews[index],
            );
          }),
    );
  }
}

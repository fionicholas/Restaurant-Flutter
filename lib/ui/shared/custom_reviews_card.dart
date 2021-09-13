import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/bloc/restaurant/model/customer_reviews.dart';
import 'package:restaurant_app/utils/assets.dart';
import 'package:restaurant_app/utils/colors.dart';

class CustomReviewsCard extends StatelessWidget {
  final CustomerReviews customerReviews;

  const CustomReviewsCard({Key? key, required this.customerReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                USER_ICON,
                width: 40,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerReviews.name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      customerReviews.date,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            customerReviews.review,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

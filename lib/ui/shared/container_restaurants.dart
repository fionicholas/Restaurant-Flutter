import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/restaurant/model/restaurant.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant_page.dart';
import 'package:restaurant_app/utils/assets.dart';
import 'package:restaurant_app/utils/colors.dart';

import 'custom_error_image.dart';
import 'custom_loading_indicator.dart';

class ContainerRestaurants extends StatefulWidget {
  final Restaurant data;

  const ContainerRestaurants({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ContainerRestaurantsState createState() => _ContainerRestaurantsState();
}

class _ContainerRestaurantsState extends State<ContainerRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailRestaurantPage.routeName,
              arguments: widget.data.id,
            );
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: widget.data.pictureId,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: MEDIUM_IMAGE_URL + widget.data.pictureId,
                      placeholder: (context, url) => CustomLoadingIndicator(),
                      errorWidget: (context, url, error) => CustomErrorImage(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.name,
                        style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(widget.data.city,
                            style: Theme.of(context).textTheme.bodyText2)
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(widget.data.rating.toString(),
                            style: Theme.of(context).textTheme.bodyText2)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

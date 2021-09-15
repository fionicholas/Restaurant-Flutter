import 'package:restaurant_app/bloc/restaurant/model/customer_reviews.dart';
import 'package:restaurant_app/bloc/restaurant/model/detail_restaurant.dart';
import 'package:restaurant_app/bloc/restaurant/model/menu.dart';
import 'package:restaurant_app/bloc/restaurant/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant/model/shared_name.dart';
import 'package:restaurant_app/data/model/favorite_entity.dart';
import 'package:restaurant_app/data/model/response/customer_reviews_item.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_item.dart';
import 'package:restaurant_app/data/model/response/menu_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';
import 'package:restaurant_app/data/model/response/shared_name_item.dart';

Restaurant mapRestaurants(RestaurantItem restaurantItem) {
  return Restaurant(
    id: restaurantItem.id ?? '',
    city: restaurantItem.city ?? '',
    pictureId: restaurantItem.pictureId ?? '',
    rating: restaurantItem.rating ?? 0.0,
    name: restaurantItem.name ?? '',
    description: restaurantItem.description ?? '',
  );
}

DetailRestaurant mapRestaurantDetail(
    DetailRestaurantItem detailRestaurantItem) {
  return DetailRestaurant(
    description: detailRestaurantItem.description ?? '',
    name: detailRestaurantItem.name ?? '',
    categories: detailRestaurantItem.categories
            ?.map((e) => mapSharedName(e))
            .toList() ??
        List.empty(),
    city: detailRestaurantItem.city ?? '',
    address: detailRestaurantItem.address ?? '',
    id: detailRestaurantItem.id ?? '',
    pictureId: detailRestaurantItem.pictureId ?? '',
    customerReviews: detailRestaurantItem.customerReviews
            ?.map((e) => mapCustomerReviews(e))
            .toList() ??
        List.empty(),
    menu: mapMenuResponse(detailRestaurantItem.menuResponse),
    rating: detailRestaurantItem.rating ?? 0.0,
  );
}

Menu mapMenuResponse(MenuResponse menuResponse) {
  return Menu(
    foods: menuResponse.foods?.map((data) => mapSharedName(data)).toList() ??
        List.empty(),
    drinks: menuResponse.drinks?.map((data) => mapSharedName(data)).toList() ??
        List.empty(),
  );
}

SharedName mapSharedName(SharedNameItem sharedNameItem) {
  return SharedName(
    name: sharedNameItem.name,
  );
}

CustomerReviews mapCustomerReviews(CustomerReviewsItem customerReviewsItem) {
  return CustomerReviews(
    name: customerReviewsItem.name ?? '',
    review: customerReviewsItem.review ?? '',
    date: customerReviewsItem.date ?? '',
  );
}

FavoriteEntity mapFavoriteEntity(Restaurant restaurant) {
  return FavoriteEntity(
    id: restaurant.id,
    city: restaurant.city,
    image: restaurant.pictureId,
    rating: restaurant.rating.toString(),
    name: restaurant.name,
    description: restaurant.description,
  );
}

Restaurant mapFavoriteToItem(FavoriteEntity favoriteEntity) {
  return Restaurant(
    id: favoriteEntity.id ?? '',
    city: favoriteEntity.city ?? '',
    pictureId: favoriteEntity.image ?? '',
    rating: double.parse(favoriteEntity.rating ?? ''),
    name: favoriteEntity.name ?? '',
    description: favoriteEntity.description ?? '',
  );
}

Restaurant mapDetailToRestaurantItem(DetailRestaurant detailRestaurant) {
  return Restaurant(
    id: detailRestaurant.id,
    city: detailRestaurant.city,
    pictureId: detailRestaurant.pictureId,
    rating: detailRestaurant.rating,
    name: detailRestaurant.name,
    description: detailRestaurant.description,
  );
}

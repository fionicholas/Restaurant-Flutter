import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/data/model/favorite_entity.dart';
import 'package:restaurant_app/data/restaurant_repository.dart';
import 'package:restaurant_app/utils/error_handler.dart';

import 'mapper/restaurant_mapper.dart';
import 'model/detail_restaurant.dart';
import 'model/restaurant.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;

  RestaurantBloc(this._restaurantRepository) : super(RestaurantInitialState());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchedRestaurantsEvent) {
      yield* _mapRestaurantsEventToState(event);
    } else if (event is FetchedRestaurantDetailEvent) {
      yield* _mapRestaurantDetailEventToState(event);
    } else if (event is AddedCustomerReviewsEvent) {
      yield* _mapAddCustomerReviewEventToState(event);
    } else if (event is SearchRestaurantEvent) {
      yield* _mapSearchRestaurantEventToState(event);
    } else if (event is FetchedFavoritesEvent) {
      yield* _mapFetchFavoriteEventToState(event);
    } else if (event is AddToFavoriteEvent) {
      yield* _mapAddToFavoriteEventToState(event);
    } else if (event is DeleteFavoriteEvent) {
      yield* _mapDeleteFavoriteEventToState(event);
    } else if (event is CheckFavoriteEvent) {
      yield* _mapCheckFavoriteEventToState(event);
    }
  }

  Stream<RestaurantState> _mapAddCustomerReviewEventToState(
      AddedCustomerReviewsEvent event) async* {
    yield AddCustomerReviewLoadingState();
    try {
      await _restaurantRepository
          .addCustomerReview(event.customerReviewRequest);
      yield AddCustomerReviewSuccessState();
    } on DioError catch (error) {
      var errorMessage = handleError(error);
      print(errorMessage);
      yield AddCustomerReviewErrorState(errorMessage);
    } on Error {
      yield AddCustomerReviewErrorState("Unknown Error");
    }
  }

  Stream<RestaurantState> _mapRestaurantsEventToState(
      FetchedRestaurantsEvent event) async* {
    yield FetchRestaurantsLoadingState();
    try {
      var restaurantsItem = await _restaurantRepository.getRestaurantData();
      List<Restaurant> restaurants =
          restaurantsItem.map((item) => mapRestaurants(item)).toList();
      yield FetchRestaurantsSuccessState(restaurants);
    } on DioError catch (error) {
      var errorMessage = handleError(error);
      print(errorMessage);
      yield FetchRestaurantsErrorState(errorMessage);
    } on Error {
      yield FetchRestaurantsErrorState("Unknown Error");
    }
  }

  Stream<RestaurantState> _mapRestaurantDetailEventToState(
      FetchedRestaurantDetailEvent event) async* {
    yield FetchRestaurantDetailLoadingState();
    try {
      var detailRestaurantItem =
          await _restaurantRepository.getDetailRestaurant(event.id);
      DetailRestaurant detailRestaurant =
          mapRestaurantDetail(detailRestaurantItem);
      yield FetchRestaurantDetailSuccessState(detailRestaurant);
    } on DioError catch (error) {
      var errorMessage = handleError(error);
      print(errorMessage);
      yield FetchRestaurantDetailErrorState(errorMessage);
    } on Error {
      yield FetchRestaurantDetailErrorState("Unknown Error");
    }
  }

  Stream<RestaurantState> _mapSearchRestaurantEventToState(
      SearchRestaurantEvent event) async* {
    yield SearchRestaurantLoadingState();
    try {
      var restaurantsItem =
          await _restaurantRepository.searchRestaurants(event.query);
      List<Restaurant> restaurants =
          restaurantsItem.map((item) => mapRestaurants(item)).toList();
      if (restaurants.isNotEmpty) {
        yield SearchRestaurantSuccessState(restaurants);
      } else {
        yield SearchRestaurantEmptyState('Data tidak ditemukan');
      }
    } on DioError catch (error) {
      var errorMessage = handleError(error);
      print(errorMessage);
      yield SearchRestaurantErrorState(errorMessage);
    } on Error {
      yield SearchRestaurantErrorState("Unknown Error");
    }
  }

  Stream<RestaurantState> _mapAddToFavoriteEventToState(
      AddToFavoriteEvent event) async* {
    yield AddToFavoriteLoadingState();
    try {
      await _restaurantRepository
          .addToFavorite(mapFavoriteEntity(event.restaurant));
      yield AddToFavoriteSuccessState(true);
    } catch (e) {
      yield AddToFavoriteErrorState(e.toString());
    }
  }

  Stream<RestaurantState> _mapDeleteFavoriteEventToState(
      DeleteFavoriteEvent event) async* {
    yield DeleteFavoriteLoadingState();
    try {
      await _restaurantRepository.deleteFavorite(event.id);
      yield DeleteFavoriteSuccessState(false);
    } catch (e) {
      yield DeleteFavoriteErrorState(e.toString());
    }
  }

  Stream<RestaurantState> _mapCheckFavoriteEventToState(
      CheckFavoriteEvent event) async* {
    yield CheckFavoriteLoadingState();
    try {
      await _restaurantRepository.checkFavoriteById(event.id);
      yield FavoredState(isFavorite: true);
    } catch (e) {
      yield UnfavorableState(e.toString(), false);
    }
  }

  Stream<RestaurantState> _mapFetchFavoriteEventToState(
      FetchedFavoritesEvent event) async* {
    yield FetchFavoritesLoadingState();
    try {
      List<FavoriteEntity> favorites =
          await _restaurantRepository.getFavorites();
      if (favorites.isEmpty) {
        yield FetchFavoritesEmptyState("Favorites Not Found");
      } else {
        yield FetchFavoritesSuccessState(
            favorites.map((e) => mapFavoriteToItem(e)).toList());
      }
    } catch (e) {
      yield FetchFavoritesErrorState(e.toString());
    }
  }
}

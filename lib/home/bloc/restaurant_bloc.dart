import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/network/model/restaurant_response.dart';
import 'package:restaurant_app/repository/restaurant_repository.dart';

part 'restaurant_event.dart';

part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial());
  RestaurantRepository repository = RestaurantRepository();

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is GetListRestaurant) {
      yield RestaurantLoading();
      try {
        final RestaurantResponse response =
            await repository.getListRestaurant();
        yield RestaurantSuccess(restaurants: response);
      } on Exception {
        yield RestaurantNoInternet();
      } catch (err) {
        yield RestaurantError();
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_response.dart';
import 'package:restaurant_app/repository/restaurant_repository.dart';

part 'detail_restaurant_event.dart';
part 'detail_restaurant_state.dart';

class DetailRestaurantBloc extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  DetailRestaurantBloc() : super(DetailRestaurantInitial());
  RestaurantRepository repository = RestaurantRepository();

  @override
  Stream<DetailRestaurantState> mapEventToState(
    DetailRestaurantEvent event,
  ) async* {
    if(event is GetDetailRestaurant) {
      yield DetailRestaurantLoading();
      try {
        final DetailRestaurantResponse response = await repository.getDetailRestaurant(event.id);
        yield DetailRestaurantSuccess(restaurant: response);
      } catch(err) {
        yield DetailRestaurantError();
      }
    }
  }
}

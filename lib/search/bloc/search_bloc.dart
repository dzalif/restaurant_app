import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/network/model/restaurant_response.dart';
import 'package:restaurant_app/network/model/search_restaurant_response.dart';
import 'package:restaurant_app/repository/restaurant_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  RestaurantRepository repository = RestaurantRepository();
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchRestaurant) {
      yield SearchLoading();
      try {
        final SearchRestaurantResponse response = await repository.searhcRestaurant(event.query);
        if (response.restaurants.isEmpty) {
          yield SearchNoData();
        } else {
          yield SearchSuccess(restaurants: response.restaurants);
        }
      } on Exception {
        yield SearchNoInternet();
      } catch(err) {
        yield SearchError();
      }
    }
  }
}

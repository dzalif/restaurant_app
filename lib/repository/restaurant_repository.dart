import 'package:restaurant_app/network/api/api_service.dart';
import 'package:restaurant_app/network/model/detail_restaurant_response.dart';
import 'package:restaurant_app/network/model/restaurant_response.dart';
import 'package:restaurant_app/network/model/search_restaurant_response.dart';
import 'package:restaurant_app/search/bloc/search_bloc.dart';

class RestaurantRepository {
  ApiService apiService = ApiService();

  Future<RestaurantResponse> getListRestaurant() {
    return apiService.getListRestaurant();
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) {
    return apiService.getDetailRestaurant(id);
  }

  Future<SearchRestaurantResponse> searhcRestaurant(String query) {
    return apiService.searchRestaurant(query);
  }
}
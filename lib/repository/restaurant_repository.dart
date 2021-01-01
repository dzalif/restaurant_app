import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_response.dart';
import 'package:restaurant_app/model/restaurant_response.dart';

class RestaurantRepository {
  ApiService apiService = ApiService();

  Future<RestaurantResponse> getListRestaurant() {
    return apiService.getListRestaurant();
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) {
    return apiService.getDetailRestaurant(id);
  }
}
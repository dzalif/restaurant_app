import 'package:restaurant_app/api/logging_interceptors.dart';
import 'package:restaurant_app/model/detail_restaurant_response.dart';
import 'package:restaurant_app/model/restaurant_response.dart';
import 'package:dio/dio.dart';

class ApiService {
  static const BASE_URL = "https://restaurant-api.dicoding.dev/";
  static const BASE_URL_IMAGE = "https://restaurant-api.dicoding.dev/images/medium/";

  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: "application/json;charset=utf-8",
    );

    var dio = Dio(options);

    dio.interceptors.add(LoggingInterceptors());

    return dio;
  }

  Future<RestaurantResponse> getListRestaurant() async {
    try {
      Response response = await dio.get('list');
      return RestaurantResponse.fromJson(response.data);
    } catch(err)  {
      throw Exception('Exception $err');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      Response response = await dio.get('detail/$id');
      return DetailRestaurantResponse.fromJson(response.data);
    } catch(err)  {
      throw Exception('Exception $err');
    }
  }
}
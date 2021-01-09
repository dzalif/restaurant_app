import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/network/model/restaurant_response.dart';

part 'search_restaurant_response.g.dart';

@JsonSerializable()
class SearchRestaurantResponse {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'founded')
  final int founded;
  @JsonKey(name: 'restaurants')
  final List<Restaurant> restaurants;

  SearchRestaurantResponse(this.error, this.founded, this.restaurants);

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRestaurantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRestaurantResponseToJson(this);
}
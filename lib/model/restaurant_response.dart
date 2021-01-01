import 'package:json_annotation/json_annotation.dart';

part 'restaurant_response.g.dart';

@JsonSerializable()
class RestaurantResponse {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'restaurants')
  final List<Restaurant> restaurants;

  RestaurantResponse(this.error, this.message, this.count, this.restaurants);

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);
}

@JsonSerializable()
class Restaurant {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'pictureId')
  final String pictureId;
  @JsonKey(name: 'city')
  final String city;
  @JsonKey(name: 'rating')
  final double rating;

  Restaurant(this.id, this.name, this.description, this.pictureId, this.city, this.rating);

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}



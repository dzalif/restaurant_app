import 'dart:convert';

import 'Menu.dart';

class RestaurantResponse {
  List<Restaurant> restaurants;

  RestaurantResponse({this.restaurants});

  RestaurantResponse.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurant>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurant.fromJson(v));
      });
    }
  }
}

List<Restaurant> parseData(String json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  return parsed["restaurants"]
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();
}

RestaurantResponse parseObject(String json) {
  final RestaurantResponse parsed = jsonDecode(json);
  return parsed;
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menu menus;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'] == null ? 0.0 : restaurant['rating'].toDouble();
    menus = restaurant['menus'] != null
        ? new Menu.fromJson(restaurant['menus'])
        : null;
  }
}

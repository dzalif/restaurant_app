import 'package:json_annotation/json_annotation.dart';

part 'detail_restaurant_response.g.dart';

@JsonSerializable()
class DetailRestaurantResponse {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'restaurant')
  final DetailRestaurant restaurant;

  DetailRestaurantResponse(this.error, this.message, this.restaurant);

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailRestaurantResponseToJson(this);
}

@JsonSerializable()
class DetailRestaurant {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'city')
  final String city;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'pictureId')
  final String pictureId;
  @JsonKey(name: 'categories')
  final List<Category> categories;
  @JsonKey(name: 'menus')
  final Menu menus;
  @JsonKey(name: 'rating')
  final double rating;
  @JsonKey(name: 'customerReviews')
  final List<Review> reviews;

  DetailRestaurant(this.id, this.name, this.description, this.city, this.address, this.pictureId, this.categories, this.menus, this.rating, this.reviews);

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$DetailRestaurantToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: 'name')
  final String name;

  Category(this.name);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Menu {
  @JsonKey(name: 'foods')
  final List<Food> foods;
  @JsonKey(name: 'drinks')
  final List<Drink> drinks;

  Menu(this.foods, this.drinks);

  factory Menu.fromJson(Map<String, dynamic> json) =>
      _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Food {
  @JsonKey(name: 'name')
  final String name;

  Food(this.name);

  factory Food.fromJson(Map<String, dynamic> json) =>
      _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

@JsonSerializable()
class Drink {
  @JsonKey(name: 'name')
  final String name;

  Drink(this.name);

  factory Drink.fromJson(Map<String, dynamic> json) =>
      _$DrinkFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}

@JsonSerializable()
class Review {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'review')
  final String review;
  @JsonKey(name: 'date')
  final String date;

  Review(this.name, this.review, this.date);

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
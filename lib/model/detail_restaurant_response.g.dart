// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailRestaurantResponse _$DetailRestaurantResponseFromJson(
    Map<String, dynamic> json) {
  return DetailRestaurantResponse(
    json['error'] as bool,
    json['message'] as String,
    json['restaurant'] == null
        ? null
        : DetailRestaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailRestaurantResponseToJson(
        DetailRestaurantResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'restaurant': instance.restaurant,
    };

DetailRestaurant _$DetailRestaurantFromJson(Map<String, dynamic> json) {
  return DetailRestaurant(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String,
    json['city'] as String,
    json['address'] as String,
    json['pictureId'] as String,
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['menus'] == null
        ? null
        : Menu.fromJson(json['menus'] as Map<String, dynamic>),
    (json['rating'] as num)?.toDouble(),
    (json['customerReviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DetailRestaurantToJson(DetailRestaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'address': instance.address,
      'pictureId': instance.pictureId,
      'categories': instance.categories,
      'menus': instance.menus,
      'rating': instance.rating,
      'customerReviews': instance.reviews,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['name'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    (json['foods'] as List)
        ?.map(
            (e) => e == null ? null : Food.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['drinks'] as List)
        ?.map(
            (e) => e == null ? null : Drink.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
    json['name'] as String,
  );
}

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
    };

Drink _$DrinkFromJson(Map<String, dynamic> json) {
  return Drink(
    json['name'] as String,
  );
}

Map<String, dynamic> _$DrinkToJson(Drink instance) => <String, dynamic>{
      'name': instance.name,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['name'] as String,
    json['review'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'name': instance.name,
      'review': instance.review,
      'date': instance.date,
    };

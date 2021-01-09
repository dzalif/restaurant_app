// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRestaurantResponse _$SearchRestaurantResponseFromJson(
    Map<String, dynamic> json) {
  return SearchRestaurantResponse(
    json['error'] as bool,
    json['founded'] as int,
    (json['restaurants'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchRestaurantResponseToJson(
        SearchRestaurantResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'founded': instance.founded,
      'restaurants': instance.restaurants,
    };

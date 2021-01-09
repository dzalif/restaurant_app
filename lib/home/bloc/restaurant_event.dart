part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class GetListRestaurant extends RestaurantEvent {}

class GetDetailRestaurant extends RestaurantEvent {
  final String id;

  GetDetailRestaurant(this.id);
}



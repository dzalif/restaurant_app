part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantError extends RestaurantState {}

class RestaurantSuccess extends RestaurantState {
  final RestaurantResponse restaurants;

  const RestaurantSuccess({@required this.restaurants});
}


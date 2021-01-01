part of 'detail_restaurant_bloc.dart';

abstract class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();

  @override
  List<Object> get props => [];
}

class DetailRestaurantLoading extends DetailRestaurantState{}

class DetailRestaurantInitial extends DetailRestaurantState {}

class DetailRestaurantError extends DetailRestaurantState {}

class DetailRestaurantSuccess extends DetailRestaurantState {
  final DetailRestaurantResponse restaurant;

  const DetailRestaurantSuccess({@required this.restaurant});
}

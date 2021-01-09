part of 'detail_restaurant_bloc.dart';

abstract class DetailRestaurantEvent extends Equatable {
  const DetailRestaurantEvent();

  @override
  List<Object> get props => [];
}

class GetDetailRestaurant extends DetailRestaurantEvent {
  final String id;

  GetDetailRestaurant(this.id);
}

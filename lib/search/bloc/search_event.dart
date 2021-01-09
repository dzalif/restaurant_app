part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRestaurant extends SearchEvent {
  final String query;

  SearchRestaurant(this.query);
}

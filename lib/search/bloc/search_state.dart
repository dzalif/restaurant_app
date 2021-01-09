part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState{}

class SearchNoInternet extends SearchState {}

class SearchError extends SearchState {}

class SearchNoData extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Restaurant> restaurants;

  SearchSuccess({this.restaurants});
}

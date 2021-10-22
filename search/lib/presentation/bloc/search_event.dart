part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class OnMovieQueryChanged extends SearchEvent {
  final String query;

  const OnMovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

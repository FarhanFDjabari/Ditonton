part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class FetchMoviesList extends MovieListEvent {
  @override
  List<Object?> get props => [];
}

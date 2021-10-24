part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieSavedToWatchlist extends MovieDetailState {
  final String message;

  const MovieSavedToWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRemovedFromWatchlist extends MovieDetailState {
  final String message;

  const MovieRemovedFromWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;
  final List<Movie> movies;
  final bool isAddedtoWatchlist;

  const MovieDetailLoaded(
    this.isAddedtoWatchlist,
    this.movies,
    this.result,
  );

  @override
  List<Object> get props => [result, movies, isAddedtoWatchlist];
}

part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();
}

class WatchlistMoviesInitial extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> movies;

  const WatchlistMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

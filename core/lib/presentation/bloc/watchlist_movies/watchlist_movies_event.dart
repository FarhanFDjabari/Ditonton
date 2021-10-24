part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();
}

class FetchWatchlistMovies extends WatchlistMoviesEvent {
  @override
  List<Object?> get props => [];
}

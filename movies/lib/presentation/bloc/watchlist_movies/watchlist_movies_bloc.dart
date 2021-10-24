import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc({required this.getWatchlistMovies})
      : super(WatchlistMoviesInitial()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (l) => emit(WatchlistMoviesError(l.message)),
        (r) => emit(
          WatchlistMoviesLoaded(r),
        ),
      );
    });
  }
}

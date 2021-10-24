import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc(
      {required this.getTopRatedMovies,
      required this.getPopularMovies,
      required this.getNowPlayingMovies})
      : super(MovieListInitial()) {
    on<FetchMoviesList>((event, emit) async {
      emit(MovieListLoading());
      final nowPlayingResult = await getNowPlayingMovies.execute();
      final popularResult = await getPopularMovies.execute();
      final topRatedResult = await getTopRatedMovies.execute();

      nowPlayingResult.fold(
        (l) => emit(MovieListError(l.message)),
        (nowPlaying) => popularResult.fold(
          (l) => emit(MovieListError(l.message)),
          (popular) => topRatedResult.fold(
            (l) => emit(MovieListError(l.message)),
            (topRated) => emit(MovieListLoaded(nowPlaying, popular, topRated)),
          ),
        ),
      );
    });
  }
}

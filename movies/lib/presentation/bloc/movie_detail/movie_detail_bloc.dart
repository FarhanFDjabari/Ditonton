import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchList => _isAddedtoWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);
      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          recommendationResult.fold(
            (failure) {
              emit(MovieDetailError(failure.message));
            },
            (movies) {
              emit(MovieDetailLoaded(_isAddedtoWatchlist, movies, movie));
            },
          );
        },
      );
    });
    on<AddMovieToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);

      await result.fold(
        (failure) async {
          emit(MovieDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.movieDetail.id);
          _isAddedtoWatchlist = result;
          emit(MovieSavedToWatchlist(successMessage));
        },
      );
    });
    on<RemoveMovieFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);

      await result.fold(
        (failure) async {
          emit(MovieDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.movieDetail.id);
          _isAddedtoWatchlist = result;
          emit(MovieRemovedFromWatchlist(successMessage));
        },
      );
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      _isAddedtoWatchlist = result;
    });
  }
}

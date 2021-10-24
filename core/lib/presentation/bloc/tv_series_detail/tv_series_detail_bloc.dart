import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  bool _isAddedtoWatchlist = false;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchlistTvSeriesStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvSeriesDetailInitial()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(TvSeriesDetailLoading());
      final detailResult = await getTvSeriesDetail.execute(event.id);
      final recommendationResult =
          await getTvSeriesRecommendations.execute(event.id);
      detailResult.fold(
        (failure) {
          emit(TvSeriesDetailError(failure.message));
        },
        (tvShowDetail) {
          recommendationResult.fold(
            (failure) {
              emit(TvSeriesDetailError(failure.message));
            },
            (recommendation) {
              emit(TvSeriesDetailLoaded(
                  _isAddedtoWatchlist, recommendation, tvShowDetail));
            },
          );
        },
      );
    });
    on<AddTvSeriesToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvSeriesDetail);

      await result.fold(
        (failure) async {
          emit(TvSeriesDetailError(failure.message));
        },
        (successMessage) async {
          final result =
              await getWatchlistTvSeriesStatus.execute(event.tvSeriesDetail.id);
          _isAddedtoWatchlist = result;
          emit(TvSeriesSavedToWatchlist(successMessage));
        },
      );
    });
    on<RemoveTvSeriesFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvSeriesDetail);

      await result.fold(
        (failure) async {
          emit(TvSeriesDetailError(failure.message));
        },
        (successMessage) async {
          final result =
              await getWatchlistTvSeriesStatus.execute(event.tvSeriesDetail.id);
          _isAddedtoWatchlist = result;
          emit(TvSeriesRemovedFromWatchlist(successMessage));
        },
      );
    });
    on<LoadTvSeriesWatchlistStatus>((event, emit) async {
      final result = await getWatchlistTvSeriesStatus.execute(event.id);
      _isAddedtoWatchlist = result;
    });
  }
}

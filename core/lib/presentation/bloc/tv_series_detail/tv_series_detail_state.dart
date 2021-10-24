part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();
}

class TvSeriesDetailInitial extends TvSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TvSeriesDetailLoading extends TvSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationLoading extends TvSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendationError extends TvSeriesDetailState {
  final String message;

  const TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesSavedToWatchlist extends TvSeriesDetailState {
  final String message;

  const TvSeriesSavedToWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRemovedFromWatchlist extends TvSeriesDetailState {
  final String message;

  const TvSeriesRemovedFromWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail result;
  final List<TvSeries> tvSeries;
  final bool isAddedtoWatchlist;

  const TvSeriesDetailLoaded(
    this.isAddedtoWatchlist,
    this.tvSeries,
    this.result,
  );

  @override
  List<Object> get props => [result, tvSeries, isAddedtoWatchlist];
}

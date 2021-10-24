part of 'tv_series_list_bloc.dart';

abstract class TvSeriesListState extends Equatable {
  const TvSeriesListState();
}

class TvSeriesListInitial extends TvSeriesListState {
  @override
  List<Object> get props => [];
}

class TvSeriesListError extends TvSeriesListState {
  final String message;

  const TvSeriesListError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesListLoading extends TvSeriesListState {
  @override
  List<Object> get props => [];
}

class TvSeriesListLoaded extends TvSeriesListState {
  final List<TvSeries> onTheAir;
  final List<TvSeries> popular;
  final List<TvSeries> topRated;

  const TvSeriesListLoaded(this.onTheAir, this.popular, this.topRated);

  @override
  List<Object> get props => [onTheAir, popular, topRated];
}

part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();
}

class PopularTvSeriesInitial extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTvSeriesLoaded extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

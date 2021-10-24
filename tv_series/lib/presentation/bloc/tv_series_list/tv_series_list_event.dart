part of 'tv_series_list_bloc.dart';

abstract class TvSeriesListEvent extends Equatable {
  const TvSeriesListEvent();
}

class FetchTvSeriesList extends TvSeriesListEvent {
  @override
  List<Object?> get props => [];
}

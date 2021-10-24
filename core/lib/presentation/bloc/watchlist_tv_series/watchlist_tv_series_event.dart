part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {
  @override
  List<Object?> get props => [];
}

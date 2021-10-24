part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddTvSeriesToWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddTvSeriesToWatchlist(this.tvSeriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveTvSeriesFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesFromWatchlist(this.tvSeriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetail];
}

class LoadTvSeriesWatchlistStatus extends TvSeriesDetailEvent {
  final int id;
  const LoadTvSeriesWatchlistStatus(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

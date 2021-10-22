part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();
}

class SearchTvInitial extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvLoading extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvError extends SearchTvState {
  final String message;

  const SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasTvSeriesData extends SearchTvState {
  final List<TvSeries> result;

  const SearchHasTvSeriesData(this.result);

  @override
  List<Object> get props => [result];
}

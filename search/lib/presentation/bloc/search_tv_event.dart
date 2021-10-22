part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();
}

class OnTvSeriesQueryChanged extends SearchTvEvent {
  final String query;

  const OnTvSeriesQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

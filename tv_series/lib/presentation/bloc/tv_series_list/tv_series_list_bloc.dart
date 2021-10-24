import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_on_the_air_tv_series.dart';
import '../../../domain/usecases/get_popular_tv_series.dart';
import '../../../domain/usecases/get_top_rated_tv_series.dart';

part 'tv_series_list_event.dart';
part 'tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc(
      {required this.getOnTheAirTvSeries,
      required this.getPopularTvSeries,
      required this.getTopRatedTvSeries})
      : super(TvSeriesListInitial()) {
    on<FetchTvSeriesList>((event, emit) async {
      emit(TvSeriesListLoading());
      final onTheAirResult = await getOnTheAirTvSeries.execute();
      final popularResult = await getPopularTvSeries.execute();
      final topRatedResult = await getTopRatedTvSeries.execute();

      onTheAirResult.fold(
        (l) => emit(TvSeriesListError(l.message)),
        (onTheAir) => popularResult.fold(
          (l) => emit(TvSeriesListError(l.message)),
          (popular) => topRatedResult.fold(
            (l) => emit(TvSeriesListError(l.message)),
            (topRated) => emit(TvSeriesListLoaded(onTheAir, popular, topRated)),
          ),
        ),
      );
    });
  }
}

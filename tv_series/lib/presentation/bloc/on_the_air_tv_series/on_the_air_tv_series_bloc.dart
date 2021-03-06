import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';

part 'on_the_air_tv_series_event.dart';
part 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  OnTheAirTvSeriesBloc({required this.getOnTheAirTvSeries})
      : super(OnTheAirTvSeriesInitial()) {
    on<FetchOnTheAirTvSeries>((event, emit) async {
      emit(OnTheAirTvSeriesLoading());
      final result = await getOnTheAirTvSeries.execute();

      result.fold(
        (l) => emit(OnTheAirTvSeriesError(l.message)),
        (r) => emit(OnTheAirTvSeriesLoaded(r)),
      );
    });
  }
}

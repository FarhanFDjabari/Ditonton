import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
      : super(TopRatedTvSeriesInitial()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (l) => emit(TopRatedTvSeriesError(l.message)),
        (r) => emit(TopRatedTvSeriesLoaded(r)),
      );
    });
  }
}

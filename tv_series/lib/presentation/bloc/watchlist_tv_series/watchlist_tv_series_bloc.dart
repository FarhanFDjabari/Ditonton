import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc({required this.getWatchlistTvSeries})
      : super(WatchlistTvSeriesInitial()) {
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (l) => emit(WatchlistTvSeriesError(l.message)),
        (r) => emit(
          WatchlistTvSeriesLoaded(r),
        ),
      );
    });
  }
}

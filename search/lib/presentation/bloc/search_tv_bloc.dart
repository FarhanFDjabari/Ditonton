import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeries searchTvSeries;

  @override
  Stream<Transition<SearchTvEvent, SearchTvState>> transformEvents(
    Stream<SearchTvEvent> events,
    TransitionFunction<SearchTvEvent, SearchTvState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  SearchTvBloc({required this.searchTvSeries}) : super(SearchTvEmpty()) {
    on<SearchTvEvent>((event, emit) async {
      if (event is OnTvSeriesQueryChanged) {
        final query = event.query;
        emit(SearchTvLoading());
        final _result = await searchTvSeries.execute(query);
        _result.fold(
          (failure) {
            emit(SearchTvError(failure.message));
          },
          (data) async {
            emit(SearchHasTvSeriesData(data));
          },
        );
      }
    });
  }
}

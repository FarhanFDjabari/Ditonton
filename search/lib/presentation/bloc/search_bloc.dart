import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  SearchBloc({required this.searchMovies}) : super(SearchEmpty()) {
    on<SearchEvent>((event, emit) async {
      if (event is OnMovieQueryChanged) {
        final query = event.query;
        emit(SearchLoading());
        final _result = await searchMovies.execute(query);
        _result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) async {
            emit(SearchHasMoviesData(data));
          },
        );
      }
    });
  }
}

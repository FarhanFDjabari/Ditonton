import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

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

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (topRated) => emit(TopRatedMoviesLoaded(topRated)),
      );
    });
  }
}

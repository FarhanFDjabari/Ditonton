import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group(
    'movie list',
    () {
      blocTest<MovieListBloc, MovieListState>(
        'should get data from the usecase',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return movieListBloc;
        },
        act: (bloc) => bloc.add(FetchMoviesList()),
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
          verify(mockGetPopularMovies.execute());
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<MovieListBloc, MovieListState>(
        'should emit [Loading, Loaded] when usecase is called',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return movieListBloc;
        },
        act: (bloc) => bloc.add(FetchMoviesList()),
        expect: () => [
          MovieListLoading(),
          MovieListLoaded(tMovieList, tMovieList, tMovieList),
        ],
      );

      blocTest<MovieListBloc, MovieListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieListBloc;
        },
        act: (bloc) => bloc.add(FetchMoviesList()),
        expect: () => [
          MovieListLoading(),
          const MovieListError('Server Failure'),
        ],
      );
    },
  );
}

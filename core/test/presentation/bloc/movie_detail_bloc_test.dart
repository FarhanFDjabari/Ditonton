import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../bloc/movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

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
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group("get movie detail and recommendation", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        "should get data from the usecase",
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should emit movies [Loading, DetailLoaded] when data is gotten successfully",
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(false, tMovies, testMovieDetail)
      ],
    );
  });

  group("watchlist", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get watchlist status",
      build: () {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should execute save watchlist when function called",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should execute remove watchlist when function called",
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update watchlist status when add watchlist success",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
      expect: () => [
        const MovieSavedToWatchlist('Added to Watchlist'),
      ],
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update watchlist message when add watchlist failed",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      expect: () => [
        const MovieDetailError('Failed'),
      ],
    );
  });

  group("on error", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should return error when data is unsuccessful",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError('Server Failure'),
      ],
    );
  });
}

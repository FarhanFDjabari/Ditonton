import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchlistTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistTvSeries,
    );
  });

  const tId = 1;

  final tTvShow = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'title',
    originCountry: const ['US'],
    originalLanguage: 'US',
    firstAirDate: '2019-02-04',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = <TvSeries>[tTvShow];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeries));
  }

  group("get tv series detail and recommendations", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should emit tv series [Loading, DetailLoaded] when data is gotten successfully",
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        TvSeriesDetailLoaded(false, tTvSeries, testTvSeriesDetail)
      ],
    );
  });

  group("get tv series watchlist", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should get watchlist status",
      build: () {
        when(mockGetWatchlistTvSeriesStatus.execute(1))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadTvSeriesWatchlistStatus(tId)),
      verify: (bloc) {
        verify(mockGetWatchlistTvSeriesStatus.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should execute save watchlist when function called",
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvSeriesDetail)),
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should execute remove watchlist when function called",
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesFromWatchlist(testTvSeriesDetail)),
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should update watchlist status when add watchlist success",
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvSeriesDetail)),
      verify: (bloc) {
        verify(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id));
      },
      expect: () => [
        const TvSeriesSavedToWatchlist('Added to Watchlist'),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should update watchlist message when add watchlist failed",
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailError('Failed'),
      ],
    );
  });

  group("on error", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should return error when data is unsuccessful",
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        const TvSeriesDetailError('Server Failure'),
      ],
    );
  });
}

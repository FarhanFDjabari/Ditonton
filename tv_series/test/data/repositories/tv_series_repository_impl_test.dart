import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tTvSeriesModel = TvSeriesModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 547,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    originalLanguage: 'US',
    originCountry: ['US'],
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvShow = TvSeries(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 547,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    originCountry: ['US'],
    originalLanguage: 'US',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvSeriesList = <TvSeries>[tTvShow];
  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];

  group('On The Air Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getOnTheAirTvSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getOnTheAirTvSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());
        verify(mockLocalDataSource.cacheOnTheAirTvSeries([testTvSeriesCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenAnswer((_) async => [testTvSeriesCache]);
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getPopularTvSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return movie list when call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenAnswer((_) async => [testTvSeriesCache]);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Top Rated Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getTopRatedTvSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return tv show list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenAnswer((_) async => [testTvSeriesCache]);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedOnTheAirTvSeries())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTvSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    const tTvSeriesResponse = TvSeriesDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalTitle',
      overview: 'overview',
      popularity: 3.4,
      posterPath: 'posterPath',
      firstAirDate: 'releaseDate',
      episodeRunTime: [120],
      status: 'Finished',
      tagline: 'Tagline',
      name: 'title',
      type: 'type',
      inProduction: true,
      lastAirDate: 'last',
      nextEpisodeToAir: 2,
      numberOfEpisodes: 3,
      numberOfSeasons: 1,
      seasons: <SeasonModel>[
        SeasonModel(
          seasonNumber: 1,
          episodeCount: 3,
          airDate: 'now',
          posterPath: '',
          overview: '',
          id: 244,
          name: 'season',
        ),
      ],
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Tv Show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'spiderman';

    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Tv Show Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Tv Show Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of Tv Shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}

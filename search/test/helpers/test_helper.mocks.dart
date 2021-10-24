// Mocks generated by Mockito 5.0.16 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i26;

import 'package:core/data/datasources/db/database_helper.dart' as _i22;
import 'package:core/utils/failure.dart' as _i8;
import 'package:core/utils/network_info.dart' as _i24;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/data/datasources/movie_local_data_source.dart' as _i18;
import 'package:movies/data/datasources/movie_remote_data_source.dart' as _i14;
import 'package:movies/data/model/movie_detail_model.dart' as _i3;
import 'package:movies/data/model/movie_model.dart' as _i15;
import 'package:movies/data/model/movie_table.dart' as _i19;
import 'package:movies/domain/entities/movie.dart' as _i9;
import 'package:movies/domain/entities/movie_detail.dart' as _i10;
import 'package:movies/domain/repositories/movie_repository.dart' as _i6;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i23;
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart'
    as _i20;
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart'
    as _i16;
import 'package:tv_series/data/models/tv_series_detail_model.dart' as _i4;
import 'package:tv_series/data/models/tv_series_model.dart' as _i17;
import 'package:tv_series/data/models/tv_series_table.dart' as _i21;
import 'package:tv_series/domain/entities/tv_series.dart' as _i12;
import 'package:tv_series/domain/entities/tv_series_detail.dart' as _i13;
import 'package:tv_series/domain/repositories/tv_series_repository.dart'
    as _i11;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvSeriesDetailResponse_2 extends _i1.Fake
    implements _i4.TvSeriesDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i11.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getOnTheAirTvSeries() => (super.noSuchMethod(
              Invocation.method(#getOnTheAirTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
              Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
              Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>>.value(
                      _FakeEither_0<_i8.Failure, _i13.TvSeriesDetail>()))
          as _i7.Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvSeriesRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i13.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i13.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i14.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i15.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i15.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i16.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i17.TvSeriesModel>> getOnTheAirTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvSeries, []),
          returnValue: Future<List<_i17.TvSeriesModel>>.value(
              <_i17.TvSeriesModel>[])) as _i7.Future<List<_i17.TvSeriesModel>>);
  @override
  _i7.Future<List<_i17.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
          returnValue: Future<List<_i17.TvSeriesModel>>.value(
              <_i17.TvSeriesModel>[])) as _i7.Future<List<_i17.TvSeriesModel>>);
  @override
  _i7.Future<List<_i17.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
          returnValue: Future<List<_i17.TvSeriesModel>>.value(
              <_i17.TvSeriesModel>[])) as _i7.Future<List<_i17.TvSeriesModel>>);
  @override
  _i7.Future<_i4.TvSeriesDetailResponse> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue: Future<_i4.TvSeriesDetailResponse>.value(
                  _FakeTvSeriesDetailResponse_2()))
          as _i7.Future<_i4.TvSeriesDetailResponse>);
  @override
  _i7.Future<List<_i17.TvSeriesModel>> getTvSeriesRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesRecommendations, [id]),
          returnValue: Future<List<_i17.TvSeriesModel>>.value(
              <_i17.TvSeriesModel>[])) as _i7.Future<List<_i17.TvSeriesModel>>);
  @override
  _i7.Future<List<_i17.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
          returnValue: Future<List<_i17.TvSeriesModel>>.value(
              <_i17.TvSeriesModel>[])) as _i7.Future<List<_i17.TvSeriesModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i18.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i19.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i19.MovieTable?>.value())
          as _i7.Future<_i19.MovieTable?>);
  @override
  _i7.Future<List<_i19.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i19.MovieTable>>.value(<_i19.MovieTable>[]))
      as _i7.Future<List<_i19.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i19.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i19.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i19.MovieTable>>.value(<_i19.MovieTable>[]))
          as _i7.Future<List<_i19.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i20.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i21.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i21.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i21.TvSeriesTable?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<_i21.TvSeriesTable?>.value())
          as _i7.Future<_i21.TvSeriesTable?>);
  @override
  _i7.Future<List<_i21.TvSeriesTable>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
          returnValue: Future<List<_i21.TvSeriesTable>>.value(
              <_i21.TvSeriesTable>[])) as _i7.Future<List<_i21.TvSeriesTable>>);
  @override
  _i7.Future<void> cacheOnTheAirTvSeries(List<_i21.TvSeriesTable>? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#cacheOnTheAirTvSeries, [tvSeries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i21.TvSeriesTable>> getCachedOnTheAirTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getCachedOnTheAirTvSeries, []),
          returnValue: Future<List<_i21.TvSeriesTable>>.value(
              <_i21.TvSeriesTable>[])) as _i7.Future<List<_i21.TvSeriesTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i22.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i23.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i23.Database?>.value())
          as _i7.Future<_i23.Database?>);
  @override
  _i7.Future<void> insertCacheTransaction(
          List<_i19.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> insertCacheTvTransaction(
          List<_i21.TvSeriesTable>? tvSeries, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTvTransaction, [tvSeries, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheTvSeries(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTvSeries, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> clearTvSeriesCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearTvSeriesCache, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertTvSeriesWatchlist(_i21.TvSeriesTable? tvSerie) => (super
      .noSuchMethod(Invocation.method(#insertTvSeriesWatchlist, [tvSerie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTvSeriesWatchlist(_i21.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(
          Invocation.method(#removeTvSeriesWatchlist, [tvSeries]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i24.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i7.Future<_i26.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

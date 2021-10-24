import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
      getOnTheAirTvSeries: mockGetOnTheAirTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
    );
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  group('Tv Series List', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      "should get data from the usecase",
      build: () {
        when(mockGetOnTheAirTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesList()),
      verify: (bloc) {
        verify(mockGetOnTheAirTvSeries.execute());
        verify(mockGetPopularTvSeries.execute());
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Loaded] when usecase is called',
      build: () {
        when(mockGetOnTheAirTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesList()),
      expect: () => [
        TvSeriesListLoading(),
        TvSeriesListLoaded(tTvSeriesList, tTvSeriesList, tTvSeriesList),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetOnTheAirTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesList()),
      expect: () => [
        TvSeriesListLoading(),
        const TvSeriesListError('Server Failure'),
      ],
    );
  });
}

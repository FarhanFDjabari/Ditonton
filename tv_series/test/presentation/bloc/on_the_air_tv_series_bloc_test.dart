import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tv_series/on_the_air_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;
  late OnTheAirTvSeriesBloc onTheAirTvSeriesBloc;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    onTheAirTvSeriesBloc = OnTheAirTvSeriesBloc(
      getOnTheAirTvSeries: mockGetOnTheAirTvSeries,
    );
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'should emit [Loading, Loaded] state when usecase is called',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return onTheAirTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      OnTheAirTvSeriesLoaded(tTvSeriesList),
    ],
  );

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAirTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      const OnTheAirTvSeriesError('Server Failure'),
    ],
  );
}

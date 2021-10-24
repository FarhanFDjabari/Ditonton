import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesBloc popularTvSeriesBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(
      getPopularTvSeries: mockGetPopularTvSeries,
    );
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emit [Loading, Loaded] state when usecase is called',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesLoaded(tTvSeriesList),
    ],
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
  );
}

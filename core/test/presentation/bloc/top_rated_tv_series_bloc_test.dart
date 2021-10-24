import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emit [Loading, Loaded] state when usecase is called',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesLoaded(tTvSeriesList),
    ],
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError('Server Failure'),
    ],
  );
}

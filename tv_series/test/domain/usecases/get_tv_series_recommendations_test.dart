import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockMovieRepository);
  });

  final tId = 1;

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesList));
  });
}

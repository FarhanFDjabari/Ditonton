import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: "/hHwEptckXUwZM7XO2lxZ8w8upuU.jpg",
    genreIds: [16, 10759],
    id: 604,
    originalName: "Teen Titans",
    overview:
        "Teen Titans is an American animated television series based on the DC Comics characters of the same name, primarily the run of stories by Marv Wolfman and George Pérez in the early-1980s The New Teen Titans comic book series. The show was created by Glen Murakami, developed by David Slack, and produced by Warner Bros. Animation. It premiered on Cartoon Network on July 19, 2003 with the episode \"Divide and Conquer\" and the final episode \"Things Change\" aired on January 16, 2006, with the film Teen Titans: Trouble in Tokyo serving as the series finale. A comic book series, Teen Titans Go!, was based on the TV series. On June 8, 2012, it was announced that the series would be revived as Teen Titans Go! in April 23, 2013 and air on the DC Nation block.IT now airs on the Boomerang channel. ",
    popularity: 1.722162,
    posterPath: "/tfdiVvJkYMbUOXDWibPjzu5dY6S.jpg",
    firstAirDate: "2003-07-19",
    name: "Teen Titans",
    originalLanguage: 'en',
    originCountry: ['US'],
    voteAverage: 8.17,
    voteCount: 12,
  );
  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/tfdiVvJkYMbUOXDWibPjzu5dY6S.jpg",
            "popularity": 1.722162,
            "id": 604,
            "backdrop_path": "/hHwEptckXUwZM7XO2lxZ8w8upuU.jpg",
            "vote_average": 8.17,
            "overview":
                "Teen Titans is an American animated television series based on the DC Comics characters of the same name, primarily the run of stories by Marv Wolfman and George Pérez in the early-1980s The New Teen Titans comic book series. The show was created by Glen Murakami, developed by David Slack, and produced by Warner Bros. Animation. It premiered on Cartoon Network on July 19, 2003 with the episode \"Divide and Conquer\" and the final episode \"Things Change\" aired on January 16, 2006, with the film Teen Titans: Trouble in Tokyo serving as the series finale. A comic book series, Teen Titans Go!, was based on the TV series. On June 8, 2012, it was announced that the series would be revived as Teen Titans Go! in April 23, 2013 and air on the DC Nation block.IT now airs on the Boomerang channel. ",
            "first_air_date": "2003-07-19",
            "origin_country": ["US"],
            "genre_ids": [16, 10759],
            "original_language": "en",
            "vote_count": 12,
            "name": "Teen Titans",
            "original_name": "Teen Titans"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

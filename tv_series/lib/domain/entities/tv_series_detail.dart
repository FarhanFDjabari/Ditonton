import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

import 'season.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.inProduction,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final bool inProduction;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Season> seasons;
  final String status;
  final String type;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        id,
        inProduction,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        type,
        voteAverage,
        voteCount
      ];
}

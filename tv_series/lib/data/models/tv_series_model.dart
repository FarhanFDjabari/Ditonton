import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double? popularity;
  final int id;
  final String? backdropPath;
  final double? voteAverage;
  final String? overview;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        posterPath: json["poster_path"] ?? "",
        popularity: json["popularity"].toDouble() ?? 0.0,
        id: json["id"],
        backdropPath: json["backdrop_path"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0.0,
        overview: json["overview"] ?? 0.0,
        firstAirDate: json["first_air_date"] ?? "",
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"] ?? "",
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  TvSeries toEntity() {
    return TvSeries(
      id: id,
      name: name,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      originalName: originalName,
      originCountry: originCountry,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName
      ];
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backgroundPath,
    required int runtime,
    required double voteAverage,
    required List<String> genres,
  }) = _MovieDetail;

  factory MovieDetail.fromJSON(Map<String, dynamic> json) => MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      runtime: json['runtime'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: List<String>.from(json['genres'].map((e) => e['name'])),
      backgroundPath: json['backdrop_path'],
      posterPath: json['poster_path']);
}

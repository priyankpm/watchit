// To parse this JSON data, do
//
//     final movieListResponseModel = movieListResponseModelFromJson(jsonString);

import 'dart:convert';

MovieListResponseModel movieListResponseModelFromJson(String str) => MovieListResponseModel.fromJson(json.decode(str));

String movieListResponseModelToJson(MovieListResponseModel data) => json.encode(data.toJson());

class MovieListResponseModel {
  int? page;
  List<MovieList>? results;

  MovieListResponseModel({
    this.page,
    this.results,
  });

  factory MovieListResponseModel.fromJson(Map<String, dynamic> json) => MovieListResponseModel(
        page: json["page"],
        results:
            json["results"] == null ? [] : List<MovieList>.from(json["results"]!.map((x) => MovieList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MovieList {
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  DateTime? releaseDate;
  bool isSaved;

  MovieList({
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.isSaved = false,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
      };
}

class CombaineModels {
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String mediaType;
  String relaseDate;
  List<int> genreIds;
  CombaineModels(
      {required this.id,
      required this.title,
      required this.voteAvg,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.mediaType,
      required this.relaseDate,
      required this.genreIds});

  factory CombaineModels.fromJson(Map<String, dynamic> json) {
    return CombaineModels(
       id: json['id'].toString(),
        title: json['title'] ?? json['name'] ?? 'no title',
        voteAvg: json['vote_average']?.toString() ?? '0.0',
        posterPath: json['poster_path']?.toString() ?? 'noPosterpPath',
        backdropPath: json['backdrop_path']?? json['poster_path'] ?? 'noBackdropPath',
        overview: json['overview'] ?? 'noReview',
        mediaType: json['media_type'] ??  'unknown',
        relaseDate: json['first_air_date'] ?? json['release_date']?.toString() ?? '-',
        genreIds: List<int>.from(json['genre_ids'] ?? []));
  }
}

class ConvertedModels {
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String relaseDate;
  String mediatype;
  List<String> genreIds;
  ConvertedModels(
      {required this.id,
      required this.genreIds,
      required this.title,
      required this.voteAvg,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.mediatype,
      required this.relaseDate});
}

class ExtraDataModels {
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String relaseDate;
  String mediatype;
  List<String> genreIds;
  String director;
  String runtime;
  String tagline;
  ExtraDataModels(
      {required this.id,
      required this.genreIds,
      required this.title,
      required this.voteAvg,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.mediatype,
      required this.relaseDate,
      required this.director,
      required this.runtime,
      required this.tagline,
      });
}

class Genres {
  String id;
  String name;
  Genres({
    required this.id,
    required this.name,
  });
  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

class ExtraData {
  String director;
  String runtime;
  ExtraData({required this.director, required this.runtime});
}

class Cast {
  String name;
  String character;
  String profilePath;
  Cast(
      {required this.name, required this.character, required this.profilePath});
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
        name: json['name'] ?? 'sdas' ,
        character: json['character']?? 'sdadas',
        profilePath: json['profile_path']?? 'ada');
  }
}

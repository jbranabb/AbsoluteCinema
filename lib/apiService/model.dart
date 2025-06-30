class MoviesModels {
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  List<int> genreIds;
  MoviesModels(
      {required this.id,
      required this.title,
      required this.voteAvg,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.genreIds});

  factory MoviesModels.fromJson(Map<String, dynamic> json) {
    return MoviesModels(
        id: json['id'].toString(),
        title: json['title'] ?? json['name'] ?? 'no title',
        voteAvg: json['vote_average']?.toString() ?? 'bla',
        posterPath: json['poster_path']?.toString()?? '',
        backdropPath: json['backdrop_path']?? 'nobackdrop',
        overview: json['overview']?? 'noowvwes',
        genreIds: List<int>.from(json['genre_ids'] ?? []));
  }
}
class TvShowsModels {
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  TvShowsModels(
      {required this.id,
      required this.title,
      required this.voteAvg,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.genreId});

  factory TvShowsModels.fromJson(Map<String, dynamic> json) {
    return TvShowsModels(
        id: json['id'].toString(),
        title: json['title'] ?? json['name'] ?? 'no title',
        voteAvg: json['vote_average'].toString(),
        backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
        overview: json['overview'],
        genreId: json['genre_ids'].toString());
  }
}

class ConvertedModels {
  String id;
  List<String> genreIds;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  ConvertedModels({
    required this.id,
    required this.genreIds,
    required this.title,
    required this.voteAvg,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
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

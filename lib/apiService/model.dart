class MovMovie {
  String title;
  String relaseDate;
  String posterPath;
  String overview;
  String rate;
  MovMovie(
      {required this.title,
      required this.relaseDate,
      required this.posterPath,
      required this.overview,
      required this.rate
      });
  factory MovMovie.fromJson(Map<String, dynamic> json,) {
    return MovMovie(
        title: json['title'],
        relaseDate: json['release_date'],
        posterPath: json['poster_path'],
        overview: json['overview'],
        rate: json['vote_average'].toString()
        );
  }
}

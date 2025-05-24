class TrendingThisWeekModel {
  String title;
  String relaseDate;
  String posterPath;
  String overview;
  String rate;
  TrendingThisWeekModel(
      {required this.title,
      required this.relaseDate,
      required this.posterPath,
      required this.overview,
      required this.rate});
  factory TrendingThisWeekModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrendingThisWeekModel(
        title: json['title'],
        relaseDate: json['release_date'],
      posterPath: json['backdrop_path'].toString(),
        overview: json['overview'],
        rate: json['vote_average'].toString());
  }
}

class NowPlayingModel {
  String genreId;
  String title;
  String overview;
  String rate;
  String posterPath;
  String relaseDate;
  NowPlayingModel(
      {required this.genreId,
      required this.overview,
      required this.posterPath,
      required this.rate,
      required this.relaseDate,
      required this.title});
      factory NowPlayingModel.fromjson(Map<String, dynamic> json){
        return NowPlayingModel(
          genreId: json['genre_ids'].toString(),
         overview: json['overview'],
          posterPath: json['poster_path'],
           rate: json['vote_average'].toString(),
            relaseDate: json['release_date'].toString(),
             title: json['title']); 
      }
}

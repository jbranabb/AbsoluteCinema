class TrendingThisWeekModel {
  String title;
  String relaseDate;
  String posterPath;
  String backdropPath;
  String overview;
  String rate;
  TrendingThisWeekModel(
      {required this.title,
      required this.relaseDate,
      required this.posterPath,
      required this.overview,
      required this.backdropPath,
      required this.rate});
  factory TrendingThisWeekModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrendingThisWeekModel(
        title: json['title'],
        relaseDate: json['release_date'],
      posterPath: json['poster_path'].toString(),
      backdropPath: json['backdrop_path'],
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

class TrendingTvShow{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  TrendingTvShow({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory TrendingTvShow.fromJson(Map<String, dynamic> json){
    return TrendingTvShow(
    id: json['id'].toString(),
     title: json['name'],
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}
class AllMovTv{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  AllMovTv({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory AllMovTv.fromJson(Map<String, dynamic> json){
    return AllMovTv(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}
class InTheatersModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  InTheatersModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory InTheatersModel.fromJson(Map<String, dynamic> json){
    return InTheatersModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}
class StreamingModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  StreamingModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory StreamingModel.fromJson(Map<String, dynamic> json){
    return StreamingModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}


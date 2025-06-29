class TrendingThisWeekModel {
  String title;
  String relaseDate;
  String posterPath;
  String backdropPath;
  String overview;
  String voteAvg;
  TrendingThisWeekModel(
      {required this.title,
      required this.relaseDate,
      required this.posterPath,
      required this.overview,
      required this.backdropPath,
      required this.voteAvg});
  factory TrendingThisWeekModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrendingThisWeekModel(
        title: json['title'],
        relaseDate: json['release_date'],
      posterPath: json['poster_path'].toString(),
      backdropPath: json['backdrop_path'],
        overview: json['overview'],
        voteAvg: json['vote_average'].toString());
  }
}

class NowPlayingModel {
  String genreId;
  String title;
  String overview;
  String voteAvg;
  String posterPath;
  String relaseDate;
  NowPlayingModel(
      {required this.genreId,
      required this.overview,
      required this.posterPath,
      required this.voteAvg,
      required this.relaseDate,
      required this.title});
      factory NowPlayingModel.fromjson(Map<String, dynamic> json){
        return NowPlayingModel(
          genreId: json['genre_ids'].toString(),
         overview: json['overview'],
          posterPath: json['poster_path'],
           voteAvg: json['vote_average'].toString(),
            relaseDate: json['release_date'].toString(),
             title: json['title']); 
      }
}

class AiringTvShowsModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  AiringTvShowsModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory AiringTvShowsModel.fromJson(Map<String, dynamic> json){
    return AiringTvShowsModel(
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
class UpcomingModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  UpcomingModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory UpcomingModel.fromJson(Map<String, dynamic> json){
    return UpcomingModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}


class OnTheAirModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
  OnTheAirModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory OnTheAirModel.fromJson(Map<String, dynamic> json){
    return OnTheAirModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}

class TrendingTvModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
 TrendingTvModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory TrendingTvModel.fromJson(Map<String, dynamic> json){
    return TrendingTvModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}

class PopularTVModel{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
 PopularTVModel({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory PopularTVModel.fromJson(Map<String, dynamic> json){
    return PopularTVModel(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}


class TopRatedTV{
  String id;
  String title;
  String voteAvg;
  String backdropPath;
  String posterPath;
  String overview;
  String genreId;
 TopRatedTV({required this.id, required this.title, required this.voteAvg,
  required this.backdropPath, required this.posterPath, required this.overview, required  this.genreId});

  factory TopRatedTV.fromJson(Map<String, dynamic> json){
    return TopRatedTV(
    id: json['id'].toString(),
     title: json['title']?? json['name']?? 'no title',
      voteAvg:json['vote_average'].toString(),
       backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
         overview: json['overview'],
          genreId: json['genre_ids'].toString());
  }
}

class GenreFromApi{
  String id;
  List<int> genreIds;
  String title;
  GenreFromApi({required this.id, required this.genreIds, required this.title});
  factory GenreFromApi.fromJson(Map<String, dynamic> json ){
    return GenreFromApi(id: json['id'].toString(),
     genreIds: List<int>.from(json['genre_ids'] ?? []) ,
     title: json['original_name']?? 'kosong title');
  }
}
class Genres{
  String id;
  String name;
  Genres({required this.id, required this.name,});
  factory Genres.fromJson(Map<String, dynamic> json ){
    return Genres(
    id: json['id'].toString(),
    name: json['name'],
    );
   }
}

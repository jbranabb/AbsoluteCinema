import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

Dio dio = Dio();
String apiKey = imdbKey;
String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchData>((event, emit) async {
      emit(StateLoading());
      try {
        var response = await dio.get(baseUrl);
        if (response.statusCode == 200) {
          print('Succses : True');
          List<dynamic> data = response.data['results'];
          print(data);
          final List<MovMovie> movies = data
              .map(
                (e) => MovMovie.fromJson(e),
              )
              .toList();
          emit(StateLoaded(list: movies));
        } else {
          emit(StateError('Something Went Wrong'));
          print('Succses : True');
        }
      } catch (e) {
        emit(StateError(e.toString()));
      }
    });
  }
}

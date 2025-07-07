import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'cast_event.dart';
part 'cast_state.dart';

Dio dio = Dio();

class CastBloc extends Bloc<CastEvent, CastState> {
  CastBloc() : super(CastInitial()) {
    on<FetchCast>((event, emit) async {
      String castUrl =
          'https://api.themoviedb.org/3/${event.mediaType}/${event.id}/credits?api_key=$imdbKey';
          print(castUrl);
      final response = await dio.get(castUrl);
      emit(StateLoading());
      if (response.statusCode == 200) {
        try {
          List<dynamic> data = response.data['cast'];
          print('data : $data');
          List<Cast> datacast = data
              .map(
                (e) => Cast.fromJson(e),
              )
              .take(5)
              .toList();
              print('datacast: $datacast');
          emit(StateLoaded(cast: datacast));
        } catch (e) {
          emit(StateError(e: e.toString()));
        }
      } else {
        emit(StateError(e: 'Terjadi Kesalahan'));
      }
    });
  }
}

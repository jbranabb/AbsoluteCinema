import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    String requestTokenUrl = 'https://api.themoviedb.org/3/authentication/token/new?api_key=$imdbKey';
    on<Authentication>((event, emit)async {
      var responseToken = await dio.get(requestTokenUrl);
      if(responseToken.statusCode == 200 && responseToken.data['success'] == true){
        final token = responseToken.data['request_token'];
        final String authGenerateUrl = 'https://www.themoviedb.org/authenticate/$token';
       emit(AuthLoaded(authGenerateUrl)); 
      }
    });

  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(CredentialsInitial()) {
    on<CredentialsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

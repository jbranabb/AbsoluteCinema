import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_user_event.dart';
part 'data_user_state.dart';

class DataUserBloc extends Bloc<DataUserEvent, DataUserState> {
  DataUserBloc() : super(DataUserInitial()) {
    on<DataUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

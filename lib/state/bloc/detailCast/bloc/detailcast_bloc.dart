import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detailcast_event.dart';
part 'detailcast_state.dart';

class DetailcastBloc extends Bloc<DetailcastEvent, DetailcastState> {
  DetailcastBloc() : super(DetailcastInitial()) {
    on<DetailcastEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

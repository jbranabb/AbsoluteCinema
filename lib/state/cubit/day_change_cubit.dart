import 'package:flutter_bloc/flutter_bloc.dart';

class DayChangeCubit extends Cubit<String>{
  DayChangeCubit() : super('');
  DateTime now = DateTime.now();
  void changeDay(){
    switch(now.hour){
      case >= 05 && < 11: 
      emit('Morning');
      case >= 11 && <= 15:
      emit('Afternoon');
      case >= 16 && <= 20:
      emit('Evening');
      default:
      emit('Night');
    }
  }

}
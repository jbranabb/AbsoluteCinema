import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int>{
  TimerCubit() : super(10);

  void handleDeniedWithTimer(){
    int startTimer = 10;
    int endTimer = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if( startTimer == endTimer ){
        timer.cancel();
      }else{
        startTimer--;
        print(startTimer);
      emit(startTimer);
      }
    },);
  }
} 

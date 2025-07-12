import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int>{
  TimerCubit() : super(0);
  void _handleDeniedWithTimer(){
    int startTimer = 10;
    int endTimer = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if( startTimer == endTimer ){
        timer.cancel();
        print('Timer Done');
      }else{
        startTimer--;
        print(startTimer);
      }
      emit(startTimer);
    },);
  }
} 

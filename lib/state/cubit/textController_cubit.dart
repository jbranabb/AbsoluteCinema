import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class TextcontrollerCubit extends Cubit<String>{
  TextcontrollerCubit() : super('');

  void updateText(String text){
  emit(text);
  }
  void clearText(){
    emit('');
  }
}
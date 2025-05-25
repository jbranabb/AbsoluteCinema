import 'package:bloc/bloc.dart';

class DotIndicator extends Cubit<int>{
  DotIndicator() : super(0);
  void changeState(int newIndex) => emit(newIndex)
;
}
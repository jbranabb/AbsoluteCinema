import 'package:bloc/bloc.dart';

class AnimatedExpands extends Cubit<bool>{
  AnimatedExpands() : super(false);
  void changeState() => emit(!state);
}
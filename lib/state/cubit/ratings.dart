import 'package:bloc/bloc.dart';

class RatingsCubit extends Cubit<double>{
  RatingsCubit() : super(0.0);
  void changeRatings(double ratings) => emit(ratings);
}
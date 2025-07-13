import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeniedCubit extends Cubit<int> {
  DeniedCubit() : super(0);
  void denied(BuildContext ctx, bool mntd) {
    var newstate = state + 1;
    emit(newstate);
    print('newstate : $newstate');
    if (newstate < 3) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1000),
          content: Text('Please click "Approve" to continue using the app')));
      Future.delayed(Durations.medium2);
    }
    if (mntd) {
      ctx.read<AuthBloc>().add(AuthDenied());
    }
  }
}

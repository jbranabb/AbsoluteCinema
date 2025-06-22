import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if(state is StateLoaded){

        }else if(state is StateLoading){

        }else if(state is StateError){

        }
        return Container();
      },) ,
    );
  }
}
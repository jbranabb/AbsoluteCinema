import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener(listener: (context, state) {
         if(state is AuthLoaded){
          
         } 
        }),
        );
  }
}

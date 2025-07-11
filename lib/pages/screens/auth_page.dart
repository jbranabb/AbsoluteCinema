import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
         if(state is AuthLoaded){
          var launched = launchUrl(Uri.parse(state.url), mode: LaunchMode.inAppBrowserView);
          // Future.delayed(Durations.extralong1);
          print('launched : ${launched.then((value) => 
          print(value),)}');    
          launched.then((value) {
            if(value == true){
            print('direct ke tmdb');
            }else{
              print('gagal');
            }
            
          },);
         } else if(state is AuthSucces){
          print(state.sessionId);
         }
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if(state is AuthLoaded){
            return Center(child:   ElevatedButton(onPressed: (){
                context.read<AuthBloc>().add(AuthExchangeToken(token: state.token ));
              }, child: Text('Validate Token')),);
          }
          return Center(child: Column(
            children: [
              ElevatedButton(onPressed: (){
                context.read<AuthBloc>().add(AuthRequestToken());
              }, child: Text('auth tmdb')),
            
            ],
          ),);
        },),
        ),
        );
  }
}

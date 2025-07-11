import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? reqtoken;
  int retryCount = 0;
  int maxRetyr = 3;
  int chance = 3;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
        if(url.contains('allow') ||  url.contains('success')){
          print('approve');
          context.read<AuthBloc>().add(AuthExchangeToken(token: reqtoken!));
        }else if(url.contains('deny')){
         print('deny');
         if(mounted){
          handleDeny();
         }
        }
      },));
  }
 void handleDeny(){
    retryCount++;
    if(retryCount >= maxRetyr){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
      Text('Kamu Sudah Mencoba Lagi Lebih dari $maxRetyr Kali, Silahkan Coba Lagi Nanti')));
      Navigator.pop(context);
     }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
      Text('Login Gagal Kamu Punya Kesempatan ${chance-1} Kali Lagi.')));
      }
      Future.delayed(Durations.medium2);
      if(mounted){
        context.read<AuthBloc>().add(AuthRequestToken());
      }
     }

  @override
  Widget build(BuildContext context) {
    print(chance);
    print(retryCount);
    print('build');
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            controller.loadRequest(Uri.parse(state.url));
            reqtoken = state.token;
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoaded) {
              return Column(
                children: [
                  Expanded(
                      child: WebViewWidget(
                    controller: controller,
                  ))
                ],
              );
            } else if (state is AuthSucces) {
                if(state.sessionId == 'null'){
                  return Center(child: Text('Gagal'),);
                }
              return Center(
                child: Text(state.sessionId),
              );
            } else if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: ElevatedButton(
                  onPressed:chance > maxRetyr ? null :  () {
                    context.read<AuthBloc>().add(AuthRequestToken());
                  },
                  child: Text('auth tmdb')),
            );
          },
        ),
      ),
    );
  }
}

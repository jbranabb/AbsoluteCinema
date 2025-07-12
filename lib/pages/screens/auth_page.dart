import 'dart:async';

import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/cubit/denied_cubit.dart';
import 'package:absolutecinema/state/cubit/timer_cubit.dart';
import 'package:flutter/gestures.dart';
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
  int decerase = 1;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          if (url.contains('allow') || url.contains('success')) {
            print('approve');
            context.read<AuthBloc>().add(AuthExchangeToken(token: reqtoken!));
          } else if (url.contains('deny')) {
            print('deny');
            if (mounted) {
              context.read<DeniedCubit>().denied(context, mounted);
            }
          }
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    print('retryCount : $retryCount');
    print('build');
    var height = MediaQuery.of(context).size.height;
    var doubleHeight = double.parse(height.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            controller.loadRequest(Uri.parse(state.url));
            reqtoken = state.token;
          } else if (state is AuthFailed && retryCount == 2) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Something Went Wrong',
                    style: TextStyle(color: Colors.white)),
                content: Text(state.e.toString(),
                    style: const TextStyle(color: Colors.white)),
              ),
            );
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
              return Center(
                child: Text(state.sessionId),
              );
            } else if (state is AuthLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            }
            return BlocBuilder<DeniedCubit, int>(
                builder: (context, state) {
                  retryCount = state;
                  return Stack(
                      children: [
                        Container(height:height,),
                        SizedBox(
                            height: 600,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/placeholder1.jpeg',
                              fit: BoxFit.cover,
                            )),
                            Container(height: 100,
                            color: Colors.red,
                            ),
                            Container(
                              height: height,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 390,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                    Colors.transparent,
                                   Colors.black
                                  ])
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: doubleHeight * 0.57,),
                              child: Container(
                                //  color: Colors.white24,
                                 height: 200,
                                 width: double.infinity,
                                 child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyText(text: 'Every Movie Has a Story.\n What`s Yours?',
                                     fnweight: FontWeight.bold, fnSize: 17,
                                     maxlines: 2,
                                     ),
                                     MyText(text: 'Rate And Track the films you love.')
                                  ],
                                 ),
                              ),
                            )
                         
                      ],
                    );
                },
              );
          },
        ),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('To continue, please select "Approve"',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          )),
      content: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: BoxBorder.all(color: Colors.blueGrey, width: 1.0)),
        child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset(
              'assets/images/Approve.jpeg',
              fit: BoxFit.fill,
            )),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: MyText(
              fnweight: FontWeight.w600,
              text: 'Nope',
              clors: Colors.grey,
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
            onPressed: () {
              context.read<AuthBloc>().add(AuthRequestToken());
              Navigator.of(context).pop();
            },
            child: MyText(
              fnweight: FontWeight.w600,
              text: 'Get In',
            ))
      ],
    );
  }
}

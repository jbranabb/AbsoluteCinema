import 'dart:async';

import 'package:absolutecinema/main.dart';
import 'package:absolutecinema/navigation.dart';
import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:absolutecinema/state/cubit/denied_cubit.dart';
import 'package:absolutecinema/state/cubit/timer_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
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
        onPageStarted: (url) {
          Center(child: LoadingWidget());
        },
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
    var paddingtop = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            controller.loadRequest(Uri.parse(state.url));
            reqtoken = state.token;
          } else if (state is AuthFailed && retryCount >= 2) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Something Went Wrong',
                    style: TextStyle(color: Colors.white)),
                content: MyText(
                  text: state.e.toString(),
                  fnweight: FontWeight.w500,
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: MyText(
                        text: 'Okay',
                        clors: Colors.black,
                        fnweight: FontWeight.w600,
                      ))
                ],
              ),
            );
          }else if(state is AuthSucces){
            context.read<UserBloc>().add(GetSessionUser(sesionId: state.sessionId));
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false,);
            print('session id : ${pref!.getString('sessionId')}');

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
            } else if (state is AuthLoading) {
              return const Center(
                child:  LoadingWidget(),
              );
            }
            return BlocBuilder<DeniedCubit, int>(
              builder: (context, state) {
                retryCount = state;
                return Stack(
                  children: [
                    Container(
                      height: height,
                    ),
                    SizedBox(
                        height: 600,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/placeholder1.jpeg',
                          fit: BoxFit.cover,
                        )),
                    Container(
                      height: 100,
                      width: 270,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                MyText(
                                    fnweight: FontWeight.bold,
                                    text: 'Absolute'),
                                MyText(
                                  fnweight: FontWeight.bold,
                                  text: 'Cinema',
                                  clors: Colors.blue.shade800,
                                )
                              ],
                            ),
                            MyText(text: 'x'),
                            Container(
                              height: 95,
                              width: 95,
                              // color: Colors.red,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // SizedBox(height: /,),
                                    Image.asset(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      'assets/images/1.png',
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
                                colors: [Colors.transparent, Colors.black])),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: doubleHeight * 0.57,
                      ),
                      child: Container(
                        // color: Colors.white24,
                        height: 310,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            MyText(
                              text: 'Every Movie Has a Story.\n What\'s Yours?',
                              fnweight: FontWeight.bold,
                              fnSize: 17,
                              maxlines: 2,
                            ),
                            MyText(
                              text: 'Rate And Track the films you love.',
                              fnweight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                state >= 3
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(milliseconds: 1000),
                                            content: Text(
                                                'Too many tries! Give it a rest and try again later')))
                                    : showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialogWidget(),
                                      );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: MyText(
                                text: state >= 3
                                    ? 'Limit Reached'
                                    : 'Let\'s Begin',
                                clors: state >= 3 ? Colors.grey : Colors.black,
                                fnweight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 50,),
                            MyText(text: 'This product uses the TMDB API but \nis not endorsed or certified by TMDB.',maxlines: 2, clors: Colors.grey.withOpacity(0.2),)
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

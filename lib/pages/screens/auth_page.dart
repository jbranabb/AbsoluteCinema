import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoaded) {
              return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final Uri _url = Uri.parse(
                          '${state.url}');
                      print('$_url');
                      try {
                        print(_url);
                        await Future.delayed(const Duration(milliseconds: 300));

                        if (!await launchUrl(_url,
                            mode: LaunchMode.externalApplication,
                            webViewConfiguration: const WebViewConfiguration(
                              enableJavaScript: true,
                              enableDomStorage: true,
                            ))) {
                          throw Exception('Could not launch the Url');
                        }
                      } catch (e) {
                        print('Error launching URL: $e');
                        if (!await launchUrl(_url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception(
                              'Could not launch the URL with fallback');
                        }
                      }
                    },
                    child: Text('login')),
              );
            } else if (state is AuthError) {
              return Center(
                child: Text(state.e),
              );
            }
            return Container();
          },
        ));
  }
}

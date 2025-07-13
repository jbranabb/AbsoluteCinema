import 'package:absolutecinema/myobserver.dart';
import 'package:absolutecinema/pages/screens/auth_page.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:absolutecinema/state/cubit/animatedContainer.dart';
import 'package:absolutecinema/state/cubit/denied_cubit.dart';
import 'package:absolutecinema/state/cubit/dot_indicator.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/state/cubit/timer_cubit.dart';
import 'package:absolutecinema/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? pref;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Myobserver();
  SharedPreferences initialpref = await SharedPreferences.getInstance();
  pref = initialpref;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(create: (context) => DotIndicator()),
      BlocProvider(create: (context) => AnimatedExpands()),
      BlocProvider(create: (context) => CastBloc()),
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => DeniedCubit()),
      BlocProvider(create: (context) => TimerCubit()),
      BlocProvider(create: (context) => UserBloc()..add(UserData())),
    ],
    child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark,  
      home: pref!.getString('sessionId') != null ? HomePage() : AuthPage() ,
    );
  }
}

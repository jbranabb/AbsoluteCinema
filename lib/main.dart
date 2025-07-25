import 'package:absolutecinema/myobserver.dart';
import 'package:absolutecinema/pages/screens/auth_page.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/pages/screens/search.dart';
import 'package:absolutecinema/pages/screens/onboarding.dart';
import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:absolutecinema/state/bloc/credentials/credentials_bloc.dart';
import 'package:absolutecinema/state/bloc/dataUser/data_user_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/bloc/search/search_bloc.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:absolutecinema/state/cubit/animatedContainer.dart';
import 'package:absolutecinema/state/cubit/day_change_cubit.dart';
import 'package:absolutecinema/state/cubit/denied_cubit.dart';
import 'package:absolutecinema/state/cubit/dot_indicator.dart';
import 'package:absolutecinema/state/cubit/onboarding_cubit.dart';
import 'package:absolutecinema/state/cubit/ratings.dart';
import 'package:absolutecinema/state/cubit/textController_cubit.dart';
import 'package:absolutecinema/state/cubit/timer_cubit.dart';
import 'package:absolutecinema/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Myobserver();
  SharedPreferences initialpref = await SharedPreferences.getInstance();
  await dotenv.load();
  pref = initialpref;

  int launchCount = pref?.getInt('launchCount') ?? 0;
    await pref?.setInt('launchCount', launchCount + 1);
    print('launchCount $launchCount');
  String? sessionId =  pref!.getString('sessionId');

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => HomeBloc()),
    BlocProvider(create: (context) => DotIndicator()),
    BlocProvider(create: (context) => AnimatedExpands()),
    BlocProvider(create: (context) => CastBloc()),
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => DeniedCubit()),
    BlocProvider(create: (context) => TimerCubit()),
    BlocProvider(create: (context) => UserBloc()),
    BlocProvider(create: (context) => CredentialsBloc()),
    BlocProvider(create: (context) => DataUserBloc()..add(FetchDataUser())),
    BlocProvider(create: (context) => SearchBloc()),
    BlocProvider(create: (context) => TextcontrollerCubit()),
    BlocProvider(create: (context) => DayChangeCubit()..changeDay()),
    BlocProvider(create: (context) => RatingsCubit()),
    BlocProvider(create: (context) => OnboardingCubit()),
  ], child: MyApp(
      launchCount: launchCount,
      sessionid:sessionId ,
  )));
}
class MyApp extends StatelessWidget {
  MyApp({super.key,
  required this.sessionid,
  required this.launchCount
  });

  int? launchCount;
  String? sessionid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark,
      home:launchCount == 0 ? const OnboardingPage() : sessionid != null ? HomePage() : AuthPage(),
    );
  }
}

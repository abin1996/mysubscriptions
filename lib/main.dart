import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_subscriptions/auth/authentication_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_subscriptions/bloc_observer.dart';
import 'package:my_subscriptions/repos/firebase_subs_repository.dart';
import 'package:my_subscriptions/repos/user_repository.dart';
import 'package:my_subscriptions/subscription/bloc/bloc.dart';
import 'package:my_subscriptions/ui/pages/home_screen.dart';
import 'package:my_subscriptions/ui/pages/login_screen.dart';
import 'package:my_subscriptions/ui/pages/splash_screen.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: App(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App(
      {Key key,
      @required UserRepository userRepository})
      : assert(
            userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        fontFamily: "OpenSans",
        focusColor: Colors.blueAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 40, color: Colors.black87, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
        fontFamily: "OpenSans",
        focusColor: Colors.blueAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 40,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode.system,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashScreen();
          }
          if (state is AuthenticationFailure) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is AuthenticationSuccess) {
            final FirebaseSubscriptionRepository subscriptionRepository =
      FirebaseSubscriptionRepository(state.displayName);
            return BlocProvider(
              create: (context) => SubscriptionBloc(subscriptionRepository: subscriptionRepository)..add(LoadSubscription()),
              child: HomeScreen(
                  name: state.displayName,
                  subscriptionRepository: subscriptionRepository),
            );
          }
          return Container();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_subscriptions/auth/authentication_bloc.dart';
import 'package:my_subscriptions/bloc_delegate.dart';
import 'package:my_subscriptions/repos/firebase_subs_repository.dart';
import 'package:my_subscriptions/repos/user_repository.dart';
import 'package:my_subscriptions/subscription/bloc/bloc.dart';
import 'package:my_subscriptions/ui/pages/home_screen.dart';
import 'package:my_subscriptions/ui/pages/login_screen.dart';
import 'package:my_subscriptions/ui/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final FirebaseSubscriptionRepository subscriptionRepository =
      FirebaseSubscriptionRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: App(
        userRepository: userRepository,
        firebaseSubscriptionRepository: subscriptionRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final FirebaseSubscriptionRepository _firebaseSubscriptionRepository;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required FirebaseSubscriptionRepository firebaseSubscriptionRepository})
      : assert(
            userRepository != null && firebaseSubscriptionRepository != null),
        _userRepository = userRepository,
        _firebaseSubscriptionRepository = firebaseSubscriptionRepository,
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
            return BlocProvider(
              create: (context) => SubscriptionBloc(subscriptionRepository: _firebaseSubscriptionRepository)..add(LoadSubscription()),
              child: HomeScreen(
                  name: state.displayName,
                  subscriptionRepository: _firebaseSubscriptionRepository),
            );
          }
          return Container();
        },
      ),
    );
  }
}

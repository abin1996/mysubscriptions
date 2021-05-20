import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_subscriptions/login/bloc/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      label: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
    );
  }
}

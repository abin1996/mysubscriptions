import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_subscriptions/auth/authentication_bloc.dart';
import 'package:my_subscriptions/models/models.dart';
import 'package:my_subscriptions/repos/firebase_subs_repository.dart';
import 'package:my_subscriptions/subscription/bloc/subscription_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final FirebaseSubscriptionRepository subscriptionRepository;

  HomeScreen(
      {Key key, @required this.name, @required this.subscriptionRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoggedOut(),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $name!')),
          subscriptions()
        ],
      ),
    );
  }

  Widget subscriptions() {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if (state is SubscriptionLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SubscriptionLoadFailure) {
          return Center(
            child: Text(
              "Failed To load subscriptions",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }
        if (state is SubscriptionLoaded) {
          List<Subscription> subscriptions = state.subscriptions;
          return Expanded(
            child: ListView.builder(
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.subscriptions[index].subsName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  );
                }),
          );
        }
        return Container();
      },
    );
  }
}

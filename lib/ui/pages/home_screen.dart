import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_subscriptions/auth/authentication_bloc.dart';
import 'package:my_subscriptions/models/models.dart';
import 'package:my_subscriptions/repos/firebase_subs_repository.dart';
import 'package:my_subscriptions/subscription/bloc/subscription_bloc.dart';
import 'package:my_subscriptions/ui/widgets/subscription_form.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Hey $name!',
                style: Theme.of(context).textTheme.bodyText1,
              )),
            ),
            subscriptions()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Theme.of(context).primaryColor),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => addSubscriptionDialog(context),
                barrierDismissible: false);
          },
          tooltip: "Add a new Subscription",
        ));
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
          if (state.subscriptions[0].subsName == "NOSUBSCRIPTION") {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Seems like you have no subscriptions currently!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            );
          }
          state.subscriptions
              .removeWhere((element) => element.subsName == "NOSUBSCRIPTION");
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

  addSubscriptionDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      content: SingleChildScrollView(
        child: SubscriptionForm(
          formKey: formKey,
          subscriptionRepository: subscriptionRepository,
        ),
      ),
      title: Text(
        "Add Subscription",
        style: Theme.of(context).textTheme.headline6,
      ),
      buttonPadding: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
    );
  }
}

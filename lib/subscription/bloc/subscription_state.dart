part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
  @override
  List<Object> get props => [];
}

class SubscriptionLoadInProgress extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<Subscription> subscriptions;

  const SubscriptionLoaded([this.subscriptions = const []]);

  @override
  List<Object> get props => [subscriptions];

  @override
  String toString() => 'SubscriptionLoaded { subscriptions: $subscriptions }';
}

class SubscriptionLoadFailure extends SubscriptionState {}

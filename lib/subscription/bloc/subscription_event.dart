part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
   @override
  List<Object> get props => [];
}

class LoadSubscription extends SubscriptionEvent {}

class AddSubscription extends SubscriptionEvent {
  final Subscription subscription;

  const AddSubscription(this.subscription);

  @override
  List<Object> get props => [subscription];

  @override
  String toString() => 'AddSubscription { todo: $subscription }';
}

class UpdateSubscription extends SubscriptionEvent {
  final Subscription subscription;

  const UpdateSubscription(this.subscription);

  @override
  List<Object> get props => [subscription];

  @override
  String toString() => 'UpdateSubscription { todo: $subscription }';
}

class DeleteSubscription extends SubscriptionEvent {
  final Subscription subscription;

  const DeleteSubscription(this.subscription);

  @override
  List<Object> get props => [subscription];

  @override
  String toString() => 'DeleteSubscription { todo: $subscription }';
}

class SubscriptionsUpdated extends SubscriptionEvent {
  final List<Subscription> subscriptions;

  const SubscriptionsUpdated(this.subscriptions);

  @override
  List<Object> get props => [subscriptions];
}
// class ClearCompleted extends SubscriptionEvent {}

// class ToggleAll extends SubscriptionEvent {}

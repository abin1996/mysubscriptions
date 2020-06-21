import 'dart:async';

import 'package:my_subscriptions/models/models.dart';

abstract class SubscriptionRepository {
  Future<void> addNewSubscription(Subscription subscription);
  Future<void> deleteSubscription(Subscription subscription);
  Stream<List<Subscription>> subscriptions();
  Future<void> updateSubscription(Subscription subscription);
}

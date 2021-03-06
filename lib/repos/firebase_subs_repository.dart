import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_subscriptions/models/models.dart';
import 'package:my_subscriptions/repos/subs_repository.dart';
import 'package:my_subscriptions/entities/entities.dart';

class FirebaseSubscriptionRepository implements SubscriptionRepository {
  var subscriptionCollection = Firestore.instance.collection("");
  FirebaseSubscriptionRepository(String userEmail) {
    this.subscriptionCollection = Firestore.instance.collection(userEmail);
  }
  @override
  Future<void> addNewSubscription(Subscription subscription) {
    return subscriptionCollection.add(subscription.toEntity().toDocument());
  }

  @override
  Future<void> deleteSubscription(Subscription subscription) async {
    return subscriptionCollection.document(subscription.subsId).delete();
  }

  @override
  Stream<List<Subscription>> subscriptions() {
    print(subscriptionCollection.snapshots());
    return subscriptionCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) =>
              Subscription.fromEntity(SubscriptionEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateSubscription(Subscription subscription) {
    return subscriptionCollection
        .document(subscription.subsId)
        .updateData(subscription.toEntity().toDocument());
  }
}

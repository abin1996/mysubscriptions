import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final String subsId;
  final String subsName;
  final DateTime subsStartDate;
  final double yearlyPrice;
  final int renewalFrequency;
  final String renewalTimeFrame;
  // final Url renewalLink;
  // final String status;

  const SubscriptionEntity(this.subsId, this.subsName, this.subsStartDate, this.yearlyPrice,
      this.renewalFrequency, this.renewalTimeFrame);

  Map<String, Object> toJson() {
    return {
      "subsName": subsName,
      "subsStartDate": subsStartDate,
      "yearlyPrice": yearlyPrice,
      "subsId": subsId,
      "renewalFrequency": renewalFrequency,
      "renewalTimeFrame": renewalTimeFrame
    };
  }

  @override
  List<Object> get props => [subsId, subsName, subsStartDate, yearlyPrice, renewalFrequency, renewalTimeFrame];

  @override
  String toString() {
    return 'SubscriptionEntity { subsId: $subsId, subsName: $subsName, subsStartDate: $subsStartDate, yearlyPrice: $yearlyPrice, renewalFrequency: $renewalFrequency, renewalTimeFrame: $renewalTimeFrame}';
  }

  static SubscriptionEntity fromJson(Map<String, Object> json) {
    return SubscriptionEntity(
      json["subsId"] as String,
      json["subsName"] as String,
      DateTime.parse(json["subsStartDate"].toString()),
      json["yearlyPrice"] as double,
      json["renewalFrequency"] as int,
      json["renewalTimeFrame"] as String,
    );
  }

  static SubscriptionEntity fromSnapshot(DocumentSnapshot snap) {
    return SubscriptionEntity(
      snap.documentID,
      snap.data['subsName'],
      DateTime.parse(snap.data['subsStartDate'].toDate().toString()),
      snap.data['yearlyPrice'].toDouble(),
      snap.data['renewalFrequency'],
      snap.data['renewalTimeFrame'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "subsName": subsName,
      "subsStartDate": subsStartDate,
      "yearlyPrice": yearlyPrice,
      "renewalFrequency": renewalFrequency,
      "renewalTimeFrame": renewalTimeFrame,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final String subsId;
  final String subsName;
  final DateTime subsStartDate;
  final double yearlyPrice;
  final String currencyCode;
  final int renewalFrequency;
  final String renewalTimeFrame;
  // final Url renewalLink;
  // final String status;

  const SubscriptionEntity(this.subsId, this.subsName, this.subsStartDate,
      this.yearlyPrice, this.currencyCode, this.renewalFrequency, this.renewalTimeFrame);

  Map<String, Object> toJson() {
    return {
      "subsName": subsName,
      "subsStartDate": subsStartDate,
      "yearlyPrice": yearlyPrice,
      "currencyCode": currencyCode,
      "subsId": subsId,
      "renewalFrequency": renewalFrequency,
      "renewalTimeFrame": renewalTimeFrame
    };
  }

  @override
  List<Object> get props => [
        subsId,
        subsName,
        subsStartDate,
        yearlyPrice,
        currencyCode,
        renewalFrequency,
        renewalTimeFrame
      ];

  @override
  String toString() {
    return 'SubscriptionEntity { subsId: $subsId, subsName: $subsName, subsStartDate: $subsStartDate, yearlyPrice: $yearlyPrice, currencyCode: $currencyCode, renewalFrequency: $renewalFrequency, renewalTimeFrame: $renewalTimeFrame}';
  }

  static SubscriptionEntity fromJson(Map<String, Object> json) {
    return SubscriptionEntity(
      json["subsId"] as String,
      json["subsName"] as String,
      DateTime.parse(json["subsStartDate"].toString()),
      json["yearlyPrice"] as double,
      json["currencyCode"] as String,
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
      snap.data['currencyCode'],
      snap.data['renewalFrequency'].toInt(),
      snap.data['renewalTimeFrame'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "subsName": subsName,
      "subsStartDate": subsStartDate,
      "yearlyPrice": yearlyPrice,
      "currencyCode": currencyCode,
      "renewalFrequency": renewalFrequency,
      "renewalTimeFrame": renewalTimeFrame,
    };
  }
}

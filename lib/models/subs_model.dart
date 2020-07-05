import 'package:meta/meta.dart';
import 'package:my_subscriptions/entities/entities.dart';
import 'package:equatable/equatable.dart';

@immutable
class Subscription extends Equatable {
  final String subsId;
  final String subsName;
  final DateTime subsStartDate;
  final double yearlyPrice;
  final String currencyCode;
  final int renewalFrequency;
  final String renewalTimeFrame;

  const Subscription(
      this.subsId,
      this.subsName,
      this.subsStartDate,
      this.yearlyPrice,
      this.currencyCode,
      this.renewalFrequency,
      this.renewalTimeFrame);

  // Subscription copyWith({bool complete, String id, String note, String task}) {
  //   return Subscription(
  //     task ?? this.task,
  //     complete: complete ?? this.complete,
  //     id: id ?? this.id,
  //     note: note ?? this.note,
  //   );
  // }

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
    return 'Subscription { subsId: $subsId, subsName: $subsName, subsStartDate: $subsStartDate, yearlyPrice: $yearlyPrice, currencyCode: $currencyCode, renewalFrequency: $renewalFrequency, renewalTimeFrame: $renewalTimeFrame}';
  }

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(subsId, subsName, subsStartDate, yearlyPrice,
        currencyCode, renewalFrequency, renewalTimeFrame);
  }

  static Subscription fromEntity(SubscriptionEntity entity) {
    return Subscription(
        entity.subsId,
        entity.subsName,
        entity.subsStartDate,
        entity.yearlyPrice,
        entity.currencyCode,
        entity.renewalFrequency,
        entity.renewalTimeFrame);
  }
}

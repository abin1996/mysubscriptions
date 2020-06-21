import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_subscriptions/models/models.dart';
import 'package:my_subscriptions/repos/subs_repository.dart';
import 'package:my_subscriptions/subscription/bloc/bloc.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _subscriptionRepository;
  StreamSubscription _streamSubscription;

  SubscriptionBloc({@required SubscriptionRepository subscriptionRepository})
      : assert(subscriptionRepository != null),
        _subscriptionRepository = subscriptionRepository;
  @override
  SubscriptionState get initialState => SubscriptionLoadInProgress();

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is LoadSubscription) {
      yield* _mapLoadSubscriptionToState();
    } else if (event is AddSubscription) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateSubscription) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteSubscription) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is SubscriptionsUpdated) {
      yield* _mapSubscriptionsUpdated(event);
    }
  }

  Stream<SubscriptionState> _mapLoadSubscriptionToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription = _subscriptionRepository.subscriptions().listen(
          (todos) => add(SubscriptionsUpdated(todos)),
        );
  }

  Stream<SubscriptionState> _mapSubscriptionsUpdated(
      SubscriptionsUpdated event) async* {
    yield SubscriptionLoaded(event.subscriptions);
  }

  Stream<SubscriptionState> _mapAddTodoToState(AddSubscription event) async* {
    _subscriptionRepository.addNewSubscription(event.subscription);
  }

  Stream<SubscriptionState> _mapUpdateTodoToState(
      UpdateSubscription event) async* {
    _subscriptionRepository.updateSubscription(event.subscription);
  }

  Stream<SubscriptionState> _mapDeleteTodoToState(
      DeleteSubscription event) async* {
    _subscriptionRepository.deleteSubscription(event.subscription);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

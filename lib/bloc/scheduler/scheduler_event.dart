import 'package:equatable/equatable.dart';

abstract class SchedulerEvent extends Equatable {
  const SchedulerEvent();
}

class ScheduledRestaurantsEvent extends SchedulerEvent {
  final bool value;

  const ScheduledRestaurantsEvent({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class PreferenceDailyReminderEvent extends SchedulerEvent {
  const PreferenceDailyReminderEvent();

  @override
  List<Object?> get props => [];
}

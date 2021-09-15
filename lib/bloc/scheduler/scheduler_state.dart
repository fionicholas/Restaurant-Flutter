import 'package:equatable/equatable.dart';

abstract class SchedulerState extends Equatable {
  const SchedulerState() : super();
}

class SchedulerInitialState extends SchedulerState {
  const SchedulerInitialState() : super();

  @override
  List<Object?> get props => [];
}

class SchedulerRestaurantEnableState extends SchedulerState {
  SchedulerRestaurantEnableState();

  @override
  List<Object> get props => [];
}

class SchedulerRestaurantDisableState extends SchedulerState {
  SchedulerRestaurantDisableState();

  @override
  List<Object> get props => [];
}

class SchedulerPreferencesEnabledState extends SchedulerState {
  final bool status;

  SchedulerPreferencesEnabledState(this.status);

  @override
  List<Object> get props => [status];
}

class SchedulerPreferencesDisabledState extends SchedulerState {
  final bool status;

  SchedulerPreferencesDisabledState(this.status);

  @override
  List<Object> get props => [status];
}

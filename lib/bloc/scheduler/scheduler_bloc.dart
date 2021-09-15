import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/scheduler/scheduler.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/preference_helper.dart';

class SchedulerBloc extends Bloc<SchedulerEvent, SchedulerState> {
  final PreferencesHelper preferencesHelper;

  SchedulerBloc(this.preferencesHelper) : super(SchedulerInitialState());

  @override
  Stream<SchedulerState> mapEventToState(SchedulerEvent event) async* {
    if (event is ScheduledRestaurantsEvent) {
      yield* _mapSchedulerRestaurantsEventToState(event);
    } else if (event is PreferenceDailyReminderEvent) {
      yield* _mapSchedulerPreferencesEventToState(event);
    }
  }

  Stream<SchedulerState> _mapSchedulerRestaurantsEventToState(
      ScheduledRestaurantsEvent event) async* {
    var _isScheduled = event.value;
    if (_isScheduled) {
      preferencesHelper.setDailyReminder(_isScheduled);
      await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
      yield SchedulerRestaurantEnableState();
    } else {
      preferencesHelper.setDailyReminder(_isScheduled);
      await AndroidAlarmManager.cancel(1);
      yield SchedulerRestaurantDisableState();
    }
  }

  Stream<SchedulerState> _mapSchedulerPreferencesEventToState(
      PreferenceDailyReminderEvent event) async* {
    var isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    if (isDailyReminderActive) {
      yield SchedulerPreferencesEnabledState(isDailyReminderActive);
    } else {
      yield SchedulerPreferencesDisabledState(isDailyReminderActive);
    }
  }
}

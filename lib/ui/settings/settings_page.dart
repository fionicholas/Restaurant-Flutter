import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/bloc/scheduler/scheduler.dart';

class SettingsPage extends StatelessWidget {
  Widget _buildList(BuildContext context, bool switchState) {
    return ListView(
      children: [
        Material(
          child: ListTile(
              title: Text('Daily Reminder'),
              trailing: Switch.adaptive(
                value: switchState,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Coming Soon!'),
                          content: Text('This feature will be coming soon!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _schedulerNotification(context, value);
                  }
                },
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _preferenceDailyReminderEvent(context);
    return BlocListener<SchedulerBloc, SchedulerState>(
      listener: (context, state) {
        if (state is SchedulerRestaurantEnableState) {
          _preferenceDailyReminderEvent(context);
          Fluttertoast.showToast(msg: "Daily Reminder is Enable");
        } else if (state is SchedulerRestaurantDisableState) {
          _preferenceDailyReminderEvent(context);
          Fluttertoast.showToast(msg: "Daily reminder is Disable");
        }
      },
      child: BlocBuilder<SchedulerBloc, SchedulerState>(
          buildWhen: (previousState, state) {
        return state is SchedulerPreferencesEnabledState ||
            state is SchedulerPreferencesDisabledState;
      }, builder: (context, state) {
        if (state is SchedulerPreferencesEnabledState) {
          bool switchState = state.status;
          return _buildList(context, switchState);
        } else if (state is SchedulerPreferencesDisabledState) {
          bool switchState = state.status;
          return _buildList(context, switchState);
        }
        return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  _schedulerNotification(BuildContext context, bool value) {
    context.read<SchedulerBloc>().add(ScheduledRestaurantsEvent(value: value));
  }

  _preferenceDailyReminderEvent(BuildContext context) {
    context.read<SchedulerBloc>().add(PreferenceDailyReminderEvent());
  }
}

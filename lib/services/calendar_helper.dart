import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import '../data/festival_dates.dart';

/// Opens the phone's calendar app with an all-day event already filled in.
Future<void> addFestivalToCalendar(
  BuildContext context,
  Festival festival,
  DateTime date,
) async {
  final begin = DateTime.utc(date.year, date.month, date.day);
  final end = begin.add(const Duration(days: 1));
  try {
    final intent = AndroidIntent(
      action: 'android.intent.action.INSERT',
      data: 'content://com.android.calendar/events',
      arguments: <String, dynamic>{
        'title': festival.name,
        'description': '${festival.subtitle}. Added from the Shri Krishna app. '
            'Dates follow the North Indian calendar and may differ by a day '
            'in some places.',
        'beginTime': begin.millisecondsSinceEpoch,
        'endTime': end.millisecondsSinceEpoch,
        'allDay': true,
      },
    );
    await intent.launch();
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open a calendar app on this phone.'),
        ),
      );
    }
  }
}

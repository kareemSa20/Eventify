import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui';
import 'package:flutter_create_eventify/event_model.dart';

class NotificationSystem {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // static Future<void> init() async {
  // await _notifications.initialize(
  //onSelectNotification: onSelectNotification,

//   );
// }

  static Future<void> showNotification(Event event) async {
    await _notifications.show(
      0,
      event.title,
      event.description,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'channelDescription',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> onSelectNotification(String payload) async {
    // Handle notification tap
  }
}

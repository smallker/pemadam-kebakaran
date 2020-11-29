import 'package:air_quality/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  void scheduleAlarm(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification',
      'notification',
      '100',
      icon: 'icon',
      sound: RawResourceAndroidNotificationSound('notification'),
      largeIcon: DrawableResourceAndroidBitmap('icon'),
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      groupKey: 'com.android.Application',
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
    );
  }
}

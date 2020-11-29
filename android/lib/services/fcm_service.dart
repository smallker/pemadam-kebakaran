import 'package:air_quality/services/notification_service.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FcmService {
  static Future<AudioPlayer> notification() async {
    AudioCache cache = new AudioCache();
    return await cache.play("notification.wav");
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    notification();
    if (message.containsKey('notification')) {
      NotificationService().scheduleAlarm(
          message['notification']['title'], message['notification']['body']);
    }
  }

  static init() {
    FirebaseMessaging fcm = FirebaseMessaging();
    fcm.subscribeToTopic('notification');

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        NotificationService().scheduleAlarm(
            message['notification']['title'], message['notification']['body']);
        // print(message);
        notification();
        Get.defaultDialog(
          title: message['notification']['title'],
          content: Center(
            child: MyText(
              text: message['notification']['body'],
              color: Colors.orange,
              fontSize: Pixel.x * 4,
            ),
          ),
          confirm: FlatButton.icon(
            label: MyText(
              text: 'OK',
              fontSize: Pixel.x * 4,
              color: Colors.grey,
            ),
            icon: Icon(Icons.check_box),
            onPressed: () => Get.back(),
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print(message);
        notification();
        NotificationService().scheduleAlarm(
            message['notification']['title'], message['notification']['body']);
        Get.defaultDialog(
          title: message['notification']['title'],
          content: Center(
            child: MyText(
              text: message['notification']['body'],
              color: Colors.orange,
              fontSize: Pixel.x * 4,
            ),
          ),
          confirm: FlatButton.icon(
            label: MyText(
              text: 'OK',
              fontSize: Pixel.x * 4,
              color: Colors.grey,
            ),
            icon: Icon(Icons.check_box),
            onPressed: () => Get.back(),
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        notification();
        NotificationService().scheduleAlarm(
            message['notification']['title'], message['notification']['body']);
        Get.defaultDialog(
          title: message['notification']['title'],
          content: Center(
            child: MyText(
              text: message['notification']['body'],
              color: Colors.orange,
              fontSize: Pixel.x * 4,
            ),
          ),
          confirm: FlatButton.icon(
            label: MyText(
              text: 'OK',
              fontSize: Pixel.x * 4,
              color: Colors.grey,
            ),
            icon: Icon(Icons.check_box),
            onPressed: () => Get.back(),
          ),
        );
      },
      onBackgroundMessage: myBackgroundMessageHandler,
    );
  }

  static getToken() async {
    FirebaseMessaging fcm = FirebaseMessaging();
    var token = await fcm.getToken();
    print(token);
  }
}

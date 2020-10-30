import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FcmService {
  static init() {
    FirebaseMessaging fcm = FirebaseMessaging();
    fcm.subscribeToTopic('notification');
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print(message);
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
    );
  }
}

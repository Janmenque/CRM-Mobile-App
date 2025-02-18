import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:hrm_app/data/model/notifications/notification_data_model.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/main.dart';
import 'package:hrm_app/utils/notification_service.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class BottomNavController extends ChangeNotifier {
  ///FirebaseMessaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool expended = false;
  int currentScreenIndex = 0;

  BottomNavController() {
    sendToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final encodedString = json.encode(message.data);
      NotificationDataModel notification =
          NotificationDataModel.fromJson(message.data);

      ///checking if title null or not if null no notification wi show
      if (notification.image == null) {
        await notificationPlugin.showNotification(
            title: notification.title ?? message.notification?.title,
            body: notification.body ?? message.notification?.body,
            payload: encodedString);
        return;
      } else {
        await notificationPlugin.showNotificationWithAttachment(
            title: notification.title ?? message.notification?.title,
            body: notification.body ?? message.notification?.body,
            image: notification.image,
            payload: encodedString);
      }
    });

    notificationPlugin.didReceivedLocalNotificationSubject.listen((value) {
      onNotificationClick(value.payload);
    });

    ///setNotificationClickListenerForLowerVersion
    notificationPlugin
        .setListenerForLowerVersion(onNotificationInLowerVersions);

    ///setNotificationClickListener
    notificationPlugin.setOnNotificationClick(onNotificationClick);

  }

  sendToken() {
    _firebaseMessaging.getToken().then((value) async {
      ///store device token to server
      ///for getting notification
      if (kDebugMode) {
        print('token firebase $value');
      }

      var deviceName = await SPUtill.getValue(SPUtill.keyAndroidDeviceToken);
      var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
      final data = {
        'user_id': userId,
        'device_name': deviceName,
        'firebase_token': value
      };

      final response = await Repository.postSentToken(data);
      if (response != null) {
        if (kDebugMode) {
          print('flutter token assign: ${response['message']}');
        }
      }
    });
  }

  ///notification click event for lower version
  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    if (kDebugMode) {
      print(receivedNotification.body);
    }
  }

  ///notification click event
  onNotificationClick(payload) {
    if (payload != null) {
      if (kDebugMode) {
        print('payload: $payload');
      }

      final map = json.decode(payload);

      NotificationDataModel notificationData =
          NotificationDataModel.fromJson(map);

      if (notificationData.type == 'leave_rejected') {
        navigatorKey.currentState!
            .pushNamed('/leave_details', arguments: notificationData.id);
      } else if (notificationData.type == 'notice') {
        navigatorKey.currentState!
            .pushNamed('/notice_screen', arguments: notificationData.id);
      } else if (notificationData.type == 'check-in') {
        navigatorKey.currentState!
            .pushNamed('/attendance', arguments: notificationData.id);
      } else if (notificationData.type == 'appointments_request') {
        navigatorKey.currentState!
            .pushNamed('/appointment_screen', arguments: notificationData.id);
      }
    }
  }
}

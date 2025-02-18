import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/notifications/notifications_model.dart';
import 'package:hrm_app/data/model/notifications/notifications_model.dart'
    as notification;
import 'package:hrm_app/data/model/notifications/read_notification.dart';
import 'package:hrm_app/data/model/response_clear_notification.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';

import '../menu/daily_leave/daily_leave/daily_leave_screen.dart';
import '../menu/leave/leave_summary/leave_summary.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? notificationModel;
  ResponseClearNotification? responseClearNotification;
  bool isLoading = false;
  List<notification.Notification>? notificationsList;
  ReadNotification? readNotification;

  NotificationProvider() {
    getNotification();
  }

  void clearNotificationApi() async {
    var apiResponse = await Repository.clearNotificationApi();
    if (apiResponse.result == true) {
      responseClearNotification = apiResponse.data;
      isLoading = true;
      getNotification();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  getNotification() async {
    final repository = await Repository.notificationList();
    notificationModel = repository.data;
    notificationsList = notificationModel?.data?.notifications;
    isLoading = true;
    notifyListeners();
  }

  getReadNotification(String? userId) async {
    final repository = await Repository.readNotification(userId);
    readNotification = repository.data;
    isLoading = true;
    getNotification();
    notifyListeners();
  }

  getRoutSlag(context, String? name) {
    switch (name) {
      case 'daily_leave':
        return NavUtil.navigateScreen(context, const DailyLeave());
      case 'leave_request':
        return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'appointment_request':
        return NavUtil.navigateScreen(context, const AppointmentScreen());
      default:
        return debugPrint('default');
    }
  }
}

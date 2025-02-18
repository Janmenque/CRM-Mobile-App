import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_base_settings.dart';
import 'package:hrm_app/data/model/response_break_history.dart';
import 'package:hrm_app/data/model/resposne_break.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_time_screen.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class BreakTimeProvider extends ChangeNotifier {
  late AnimationController controller;
  ResponseBreak? responseBreakTime;
  String? currentTimeServer;
  String? checkStatus;
  ResponseBreakHistory? responseBreakHistory;
  bool isLoading = false;
  ResponseBaseSetting? baseSetting;
  int? hour;
  int? minutes;
  int? seconds;
  late String diffTime;
  bool isDiffTime = false;
  String? test = "Testing";
  late CustomTimerController controllerBreakTimer;

  BreakTimeProvider(AnimationController controller, BuildContext context,
      int? hourHome, int? secondsHome, int? minutesHome, CustomTimerController breakTimerController) {
    controllerBreakTimer = breakTimerController;
    getBaseSetting(controllerBreakTimer);
    breakHistoryApi();
    getAttendance(controller, controllerBreakTimer, context, hourHome,
        secondsHome, minutesHome);
  }

  getBaseSetting(CustomTimerController customTimerController) async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      baseSetting = apiResponse.data;
      checkStatus = baseSetting?.data?.breakStatus?.status.toString();
      if (baseSetting!.data!.breakStatus != null) {
        diffTime = baseSetting!.data!.breakStatus!.diffTime!;
      }
      if (diffTime.isNotEmpty) {
        var str = diffTime;
        var parts = str.split(':');
        hour = int.parse(parts[0].trim());
        minutes = int.parse(parts[1].trim());
        seconds = int.parse(parts[2].trim());
        isDiffTime = true;
        customTimerController.start();
        notifyListeners();
      }
      notifyListeners();
    }
  }

  ///get current date time
  void currentDateTime() {
    DateTime now = DateTime.now();
    currentTimeServer = DateFormat('HH:mm:ss').format(now);
    notifyListeners();
  }

  /// Break API
  getAttendance(
      AnimationController controller,
      CustomTimerController customTimerController,
      BuildContext context,
      int? hourHome,
      int? secondsHome,
      int? minutesHome,
      ) {
    controller.addListener(() {
      if (controller.value.toInt() == 1) {
        currentDateTime();
        checkStatus == "break_in"
            ? getBreakTimeApi("back", customTimerController, hourHome,
            secondsHome, minutesHome, context)
            : getBreakTimeApi("start", customTimerController, hourHome,
            secondsHome, minutesHome, context);
        controller.reset();
      }
      notifyListeners();
    });
  }

  /// Break history api
  void breakHistoryApi() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId= BodyUserId(userId: userId);
    var apiResponse = await Repository.breakHistoryApi(bodyUserId);
    if (apiResponse.result == true) {
      responseBreakHistory = apiResponse.data;
      isLoading = true;
      notifyListeners();
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

  /// Break time api
  void getBreakTimeApi(
      String? statusSlug,
      CustomTimerController customTimerController,
      int? hourHome,
      int? secondsHome,
      int? minutesHome,
      context) async {
    var bodyBreakTime = BodyBreakTime(time: currentTimeServer);
    var apiResponse = await Repository.breakTimeApi(bodyBreakTime, statusSlug);
    if (apiResponse.result == true) {
      responseBreakTime = apiResponse.data;
      checkStatus = responseBreakTime?.data?.status;
      if (checkStatus == "break_in") {
        customTimerController.start();
      } else if (checkStatus == "break_out") {
        customTimerController.reset();
        breakHistoryApi();
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const BreakTime(
          diffTimeHome: '',
          hourHome: 0,
          minutesHome: 0,
          secondsHome: 0,
        )));
      }
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      notifyListeners();
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
}

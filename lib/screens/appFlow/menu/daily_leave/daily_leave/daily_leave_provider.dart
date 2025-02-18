import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/all_designation_wise_user/all_designation_wise_user.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_summary_response.dart';
import 'package:hrm_app/data/server/respository/daily_leave_repository/daily_leave_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/apply_leave/apply_leave_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import '../../../../../data/model/home/crm_home_model.dart';
import '../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class DailyLeaveProvider extends ChangeNotifier {
  String? currentMonth;
  String? monthYear;
  String? showMonth;
  DateTime? selectedDate;
  DailyLeaveSummaryResponse? dailyLeaveSummary;
  bool isLoading = false;
  int? userId;
  bool? isHr;

  Members? allUserData;

  DailyLeaveProvider(AnimationController controller, context) {
    getHr();
    applyLeave(controller, context);
    getDate();
    getUserId();
  }

  Future getUserId() async{
    userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    await getDailySummery();
  }
  Future getHr() async {
    isHr = await SPUtill.getBoolValue(SPUtill.keyIsHr);
  }

  Future getDailySummery() async {
    final data = {'month': monthYear, 'user_id': userId};
    final response = await DailyLeaveRepository.postDailyLeaveSummery(data);
    if (response.result == true) {
      dailyLeaveSummary = response.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: tr("something_went_wrong"));
    }
  }


  /// AppreciateTeammate screen
  void getAllUserData(BuildContext context) async {
    allUserData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllDesignationWiseUser()),
    );
    userId = allUserData?.id;
    getDailySummery();
    notifyListeners();
  }

  leaveSummaryProvider(AnimationController controller, context) {
    applyLeave(controller, context);
  }

  applyLeave(AnimationController controller, context) {
    controller.addListener(() {
      if (controller.value.toInt() == 1) {
        NavUtil.navigateScreen(context, ApplyLeaveScreen(
          onBack: () {
            getDailySummery();
            notifyListeners();
          },
        ));
        controller.reset();
        notifyListeners();
      } else {}
      notifyListeners();
    });
  }

  /// Get current date and Format
  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM').format(currentDate);
    monthYear = DateFormat('y-MM').format(currentDate);
    showMonth = DateFormat('MMMM y').format(currentDate);
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        currentMonth = DateFormat('y-MM').format(selectedDate!);
        monthYear = DateFormat('y-MM').format(selectedDate!);
        showMonth = DateFormat('MMMM y').format(selectedDate!);
        getDailySummery();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  /// Select date.....
  Future selectMonthDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        currentMonth = DateFormat('y-MM').format(selectedDate!);
        monthYear = DateFormat('y-MM-d').format(selectedDate!);
        showMonth = DateFormat('d MMMM y').format(selectedDate!);
        getDailySummery();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}

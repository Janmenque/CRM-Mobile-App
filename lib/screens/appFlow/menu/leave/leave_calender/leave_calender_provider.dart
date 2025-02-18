import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_note/create_leave_request.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalenderProvider extends ChangeNotifier {
  String? startDate;
  String? endDate;

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (kDebugMode) {
      print(DateFormat('yyyy-MM-dd').format(args.value.startDate).toString());
      print(DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString());
    }
    startDate =
        DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
    endDate = DateFormat('yyyy-MM-dd')
        .format(args.value.endDate ?? args.value.startDate)
        .toString();
    notifyListeners();
  }

  void getDateFromCalender(BuildContext context,int? leaveTypeId) {
    if (startDate != null) {
      NavUtil.replaceScreen(
          context,
          CreateLeaveRequest(
            starDate: startDate,
            endDate: endDate,
            leaveTypeId: leaveTypeId,
          ));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogError(
              title: tr('select_a_date'),
              subTitle: tr('you_must_be_select_a_date_please_select_a_date_for_continue'),
            );
          });
    }
  }
}

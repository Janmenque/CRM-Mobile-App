import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../custom_widgets/custom_dialog.dart';
import '../../../../../data/model/expense_model/response_expense_list.dart';
import '../../../../../data/server/respository/expense_repository.dart';

class ExpenseItemProvider extends ChangeNotifier {
  DateTime? expenseDate;
  DateTime? selectedDate;

  String? startDate = "";
  String? endDate = "";
  String? paymentTypeValue;
  String? expenseStatus;
  List<ExpenseItem>?  expenseList;
  int? paymentTypeServer;
  int? expenseStatusServer;

  ExpenseItemProvider(context) {
    expenseListApi(context);
  }

  /// dropdownMenu for Payment type .....
  void paymentTypeMenu(String? newValue, context) {
    paymentTypeValue = newValue;
    if (kDebugMode) {
      print(paymentTypeValue);
    }
    if (paymentTypeValue == "Paid") {
      paymentTypeServer = 8;
    } else {
      paymentTypeServer = 9;
    }
    expenseListApi(context);
    notifyListeners();
  }

  /// dropdownMenu for Expense Status .....
  void expenseStatusMenu(String? newValue, context) {
    expenseStatus = newValue;
    if (kDebugMode) {
      print(expenseStatus);
    }
    if (expenseStatus == "Pending") {
      expenseStatusServer = 2;
    } else if (expenseStatus == "Approved") {
      expenseStatusServer = 5;
    } else {
      expenseStatusServer = 6;
    }
    expenseListApi(context);
    notifyListeners();
  }

  /// Select date data of joining function.....
  Future selectDate(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SfDateRangePicker(
                      view: DateRangePickerView.month,
                      selectionColor: Colors.green,
                      showNavigationArrow: true,
                      toggleDaySelection: false,
                      enablePastDates: true,
                      selectionShape: DateRangePickerSelectionShape.circle,
                      onSelectionChanged: onSelectionChanged,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          weekendDays: <int>[6, 3]),
                      selectionMode: DateRangePickerSelectionMode.range,
                    ),
                    InkWell(
                      onTap: () {
                        getDateFromCalender(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimary,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: 150,
                          height: 40,
                          child: const Center(
                              child: Text(
                            "okey",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void getDateFromCalender(BuildContext context) {
    if (startDate != null) {
      Navigator.pop(context);
      expenseListApi(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogError(
              title: tr('select_a_date'),
              subTitle: tr(
                  'you_must_be_select_a_date_please_select_a_date_for_continue'),
            );
          });
    }
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (kDebugMode) {
      print(DateFormat('yyyy/MM/dd').format(args.value.startDate).toString());
      print(DateFormat('yyyy/MM/dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString());
    }
    startDate =
        DateFormat('yyyy/MM/dd').format(args.value.startDate).toString();
    endDate = DateFormat('yyyy/MM/dd')
        .format(args.value.endDate ?? args.value.startDate)
        .toString();
  }

  /// Create expense:-----------------
  Future expenseListApi(context) async {
    String? dateRange;

    if (startDate!.isNotEmpty) {
      dateRange = "$startDate - $endDate";
    } else {
      dateRange = "";
    }
    var fromData = FormData.fromMap({
      "date": dateRange,
      "payment": paymentTypeServer,
      "status": expenseStatusServer
    });
    final response = await ExpenseRepository.expenseList(fromData);
    if (response.result == true) {
      expenseList = response.data?.data;
      notifyListeners();
    }
    notifyListeners();
  }
}

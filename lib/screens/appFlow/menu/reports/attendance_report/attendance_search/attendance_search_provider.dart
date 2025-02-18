import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_attendance_report.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/model/response_user_search.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_employee_search.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class AttendanceSearchProvider extends ChangeNotifier {
  DateTime? selectedDate;
  String? currentMonth;
  AttendanceReport? responseReport;
  String? monthYear;
  User? userObj;
  ResponseOfficialInfo? officialInfo;

  AttendanceSearchProvider() {
    getDate();
    attendanceReportApi();
    getOfficialInfo();
  }

  /// get data from EmployeeData screen
  void getEmployeeData(BuildContext context) async {
    userObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AttendanceEmployeeSearch()),
    );
    attendanceReportApi();
    getOfficialInfo();
    notifyListeners();
  }

  /// getOfficialInfo API .............
  void getOfficialInfo() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(
      userId: userObj?.id ?? userIdKey,
    );

    var apiResponseOfficial = await ProfileRepository.getOfficialInfo(
        bodyUserId, AppConst.officialSlug);
    if (apiResponseOfficial.result == true) {
      officialInfo = apiResponseOfficial.data;
      if (kDebugMode) {
        print(apiResponseOfficial.data);
      }
      notifyListeners();
    } else {
      final errorMessage = apiResponseOfficial.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM').format(currentDate);
    monthYear = DateFormat('MMMM,y').format(currentDate);
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        currentMonth = DateFormat('y-MM').format(selectedDate!);
        monthYear = DateFormat('MMMM,y').format(selectedDate!);
        attendanceReportApi();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  ///get Attendance Report
  attendanceReportApi() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var userId = userObj?.id ?? userIdKey;
    var bodyAttendanceReport = BodyAttendanceReport(month: currentMonth);
    var apiResponse =
        await Repository.attendanceReport(bodyAttendanceReport, userId);
    if (apiResponse.result == true) {
      responseReport = apiResponse.data;
      notifyListeners();
    }
  }

  Widget getWidget(DailyReport? dailyReport, BuildContext context) {
    switch (dailyReport?.status) {
      case "Present":
        String? remoteModeIn;
        String? remoteModeOut;
        String checkInColor;
        String checkOutColor;

        /// remote mode In-> Home or Office
        int remoteIn = int.parse(dailyReport?.remoteModeIn ?? "1");
        if (remoteIn == 0) {
          remoteModeIn = "H";
        } else {
          remoteModeIn = "V";
        }

        int? remoteOut = int.tryParse(dailyReport!.remoteModeOut!);
        if (remoteOut == 0) {
          remoteModeOut = "H";
        } else {
          remoteModeOut = "V";
        }

        /// CheckIn Status Color
        if (dailyReport.checkInStatus == "OT") {
          checkInColor = "0xff46A44D"; //green Color
        } else if (dailyReport.checkInStatus == "L") {
          checkInColor = "0xffF44336"; // red Color
        } else if (dailyReport.checkInStatus == "A") {
          checkInColor = "0xff000000"; // Black Color
        } else if (dailyReport.checkInStatus == "LT") {
          checkInColor = "0xff46A44D"; //green Color
        } else if (dailyReport.checkInStatus == "LL") {
          checkInColor = "0xffFFC107"; // yellow Color
        } else {
          checkInColor = "0xff46A44D"; //green Color
        }

        /// CheckOut Status Color
        if (dailyReport.checkOutStatus == "OT") {
          checkOutColor = "0xff46A44D"; //green Color
        } else if (dailyReport.checkOutStatus == "LE") {
          checkOutColor = "0xffF44336"; // red Color
        } else if (dailyReport.checkOutStatus == "L") {
          checkOutColor = "0xffF44336"; // red Color
        } else if (dailyReport.checkOutStatus == "A") {
          checkOutColor = "0xff000000"; // Black Color
        } else if (dailyReport.checkOutStatus == "LT") {
          checkOutColor = "0xff46A44D"; //green Color
        } else if (dailyReport.checkOutStatus == "LL") {
          checkOutColor = "0xffFFC107"; // yellow Color
        } else {
          checkOutColor = "0xff46A44D"; //green Color
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      dailyReport.weekDay ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      dailyReport.date ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "IN",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 26,
                          ),
                          Visibility(
                            visible: dailyReport.checkIn?.isNotEmpty == true,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(int.parse(checkInColor)),
                                      style: BorderStyle.solid,
                                      width: 3.0,
                                    ),
                                    color: Color(int.parse(checkInColor)),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DottedBorder(
                                    color: Colors.white,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    strokeWidth: 1,
                                    child: Text(
                                      dailyReport.checkIn ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: () {
                                    getLocationIn(dailyReport);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueAccent),
                                      child: Center(
                                          child: Text(
                                        remoteModeIn,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      dailyReport.checkInReason?.isNotEmpty ==
                                          true,
                                  child: InkWell(
                                    onTap: () {
                                      getReasonIn(dailyReport);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.article_outlined,
                                        color: Colors.blue,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      color: const Color(0xffFCF6FF),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "OUT",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dailyReport.checkOut?.isNotEmpty == true,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(int.parse(checkOutColor)),
                                      style: BorderStyle.solid,
                                      width: 3.0,
                                    ),
                                    color: Color(int.parse(checkOutColor)),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DottedBorder(
                                    color: Colors.white,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    strokeWidth: 1,
                                    child: Text(
                                      dailyReport.checkOut ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Visibility(
                                  visible:
                                      dailyReport.remoteModeOut?.isNotEmpty ==
                                          true,
                                  child: InkWell(
                                    onTap: () {
                                      getLocationOut(dailyReport);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blueAccent),
                                        child: Center(
                                            child: Text(
                                          remoteModeOut,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      dailyReport.checkOutReason?.isNotEmpty ==
                                          true,
                                  child: InkWell(
                                    onTap: () {
                                      getReasonOut(dailyReport);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.article_outlined,
                                        color: Colors.blue,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case "Absent":
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      dailyReport?.weekDay ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      dailyReport?.date ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                dailyReport?.status ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case "Weekend":
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      dailyReport?.weekDay ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      dailyReport?.date ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                dailyReport?.status ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case "Holiday":
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      dailyReport?.weekDay ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      dailyReport?.date ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                dailyReport?.status ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  void getLocationIn(DailyReport? dailyReport) {
    Fluttertoast.showToast(
        msg: dailyReport?.checkInLocation ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getLocationOut(DailyReport? dailyReport) {
    Fluttertoast.showToast(
        msg: dailyReport?.checkInLocation ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getReasonIn(DailyReport? dailyReport) {
    Fluttertoast.showToast(
        msg: dailyReport?.checkInReason ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getReasonOut(DailyReport? dailyReport) {
    Fluttertoast.showToast(
        msg: dailyReport?.checkOutReason ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }
}

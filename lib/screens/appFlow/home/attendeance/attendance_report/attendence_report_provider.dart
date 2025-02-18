import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/attendance_daily_report.dart';
import 'package:hrm_app/data/model/response_attendance_report.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class AttendanceReportProvider extends ChangeNotifier {
  DateTime? selectedDate;
  String? currentMonth;
  AttendanceReport? responseReport;
  String? monthYear;
  AttendanceDailyReport? responseDailyReport;
  bool isLoadingDaily = false;
  bool? isMultiCheckIn;

  AttendanceReportProvider() {
    getSettingBase();
    getDate();
    attendanceReportApi();
  }

  /// IP Base setting
  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isMultiCheckIn = apiResponse.data?.data?.multiCheckIn;
      if (kDebugMode) {
        print("isMultiCheckIn : $isMultiCheckIn");
      }
      notifyListeners();
    }
  }

  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM','en').format(currentDate);
    monthYear = DateFormat('MMMM,y','en').format(currentDate);
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
        currentMonth = DateFormat('y-MM','en').format(selectedDate!);
        monthYear = DateFormat('MMMM,y','en').format(selectedDate!);
        attendanceReportApi();
        if (kDebugMode) {
          print(DateFormat('y-MM','en').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  ///get Attendance Report
  attendanceReportApi() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyAttendanceReport = BodyAttendanceReport(month: currentMonth);
    var apiResponse =
        await Repository.attendanceReport(bodyAttendanceReport, userId);
    if (apiResponse.result == true) {
      responseReport = apiResponse.data;
      notifyListeners();
    }
  }

  ///get attendanceDailyReportApi
  attendanceDailyReportApi(String? date, context) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    if (kDebugMode) {
      print(date);
    }
    var apiResponse = await Repository.attendanceReportDaily(date, userId);
    if (apiResponse.result == true) {
      isLoadingDaily = true;
      responseDailyReport = apiResponse.data;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(responseDailyReport?.data?.date ?? ""),
              content: dialogCheckList(),
            );
          });
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

        /// remote mode Out-> Home or Office
        int? remoteOut = int.tryParse(dailyReport?.remoteModeOut ?? "0");
        if (remoteOut == 0) {
          remoteModeOut = "H";
        } else {
          remoteModeOut = "V";
        }

        /// CheckIn Status Color
        if (dailyReport?.checkInStatus == "OT") {
          checkInColor = "0xff46A44D"; //green Color
        } else if (dailyReport?.checkInStatus == "L") {
          checkInColor = "0xffF44336"; // red Color
        } else if (dailyReport?.checkInStatus == "A") {
          checkInColor = "0xff000000"; // Black Color
        } else if (dailyReport?.checkInStatus == "LT") {
          checkInColor = "0xff46A44D"; //green Color
        } else if (dailyReport?.checkInStatus == "LL") {
          checkInColor = "0xffFFC107"; // yellow Color
        } else {
          checkInColor = "0xff46A44D"; //green Color
        }

        /// CheckOut Status Color
        if (dailyReport?.checkOutStatus == "OT") {
          checkOutColor = "0xff46A44D"; //green Color
        } else if (dailyReport?.checkOutStatus == "LE") {
          checkOutColor = "0xffF44336"; // red Color
        } else if (dailyReport?.checkOutStatus == "L") {
          checkOutColor = "0xffF44336"; // red Color
        } else if (dailyReport?.checkOutStatus == "A") {
          checkOutColor = "0xff000000"; // Black Color
        } else if (dailyReport?.checkOutStatus == "LT") {
          checkOutColor = "0xff46A44D"; //green Color
        } else if (dailyReport?.checkOutStatus == "LL") {
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
                      padding: const EdgeInsets.only(left: 10),
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
                            width: 20,
                          ),
                          Visibility(
                            visible: dailyReport?.checkIn?.isNotEmpty == true,
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
                                      dailyReport?.checkIn ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
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
                                      dailyReport?.checkInReason?.isNotEmpty ==
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
                      padding: const EdgeInsets.only(left: 10),
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
                            visible: dailyReport?.checkOut?.isNotEmpty == true,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
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
                                      dailyReport?.checkOut ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Visibility(
                                  visible:
                                      dailyReport?.remoteModeOut?.isNotEmpty ==
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
                                      dailyReport?.checkOutReason?.isNotEmpty ==
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
              Visibility(
                visible: isMultiCheckIn ?? false,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        String? date = dailyReport?.fullDate;
                        attendanceDailyReportApi(date, context);
                      },
                      child: Lottie.asset(
                        'assets/images/report_one.json',
                        height: 55,
                        width: 55,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
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
      case "...":
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
                          Opacity(
                            opacity: 0,
                            child: Container(
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

  Widget dialogCheckList() {
    DateWiseReport? dateWiseReport;

    String? remoteModeIn;
    String? remoteModeOut;
    String checkInColor;
    String checkOutColor;

    /// remote mode In-> Home or Office
    int remoteIn = int.parse(dateWiseReport?.remoteModeIn ?? "1");
    if (remoteIn == 0) {
      remoteModeIn = "H";
    } else {
      remoteModeIn = "V";
    }

    /// remote mode Out-> Home or Office
    int? remoteOut = int.tryParse(dateWiseReport?.remoteModeOut ?? "0");
    if (remoteOut == 0) {
      remoteModeOut = "H";
    } else {
      remoteModeOut = "V";
    }

    /// CheckIn Status Color
    if (dateWiseReport?.checkInStatus == "OT") {
      checkInColor = "0xff46A44D"; //green Color
    } else if (dateWiseReport?.checkInStatus == "L") {
      checkInColor = "0xffF44336"; // red Color
    } else if (dateWiseReport?.checkInStatus == "A") {
      checkInColor = "0xff000000"; // Black Color
    } else if (dateWiseReport?.checkInStatus == "LT") {
      checkInColor = "0xff46A44D"; //green Color
    } else if (dateWiseReport?.checkInStatus == "LL") {
      checkInColor = "0xffFFC107"; // yellow Color
    } else {
      checkInColor = "0xff46A44D"; //green Color
    }

    /// CheckOut Status Color
    if (dateWiseReport?.checkOutStatus == "OT") {
      checkOutColor = "0xff46A44D"; //green Color
    } else if (dateWiseReport?.checkOutStatus == "LE") {
      checkOutColor = "0xffF44336"; // red Color
    } else if (dateWiseReport?.checkOutStatus == "L") {
      checkOutColor = "0xffF44336"; // red Color
    } else if (dateWiseReport?.checkOutStatus == "A") {
      checkOutColor = "0xff000000"; // Black Color
    } else if (dateWiseReport?.checkOutStatus == "LT") {
      checkOutColor = "0xff46A44D"; //green Color
    } else if (dateWiseReport?.checkOutStatus == "LL") {
      checkOutColor = "0xffFFC107"; // yellow Color
    } else {
      checkOutColor = "0xff46A44D"; //green Color
    }
    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child:  ListView.builder(
        shrinkWrap: true,
        itemCount:
            responseDailyReport?.data?.dateWiseReport?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          dateWiseReport =
              responseDailyReport?.data?.dateWiseReport?[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
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
                      width: 20,
                    ),
                    Visibility(
                      visible:
                          dateWiseReport?.checkIn?.isNotEmpty ==
                              true,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Color(int.parse(checkInColor)),
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              color: Color(int.parse(checkInColor)),
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                dateWiseReport?.checkIn ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () {
                              getLocationInDaily(dateWiseReport);
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
                                  remoteModeIn ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dateWiseReport
                                    ?.checkInReason?.isNotEmpty ==
                                true,
                            child: InkWell(
                              onTap: () {
                                getReasonInDaily(dateWiseReport);
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
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
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
                      visible:
                          dateWiseReport?.checkOut?.isNotEmpty ==
                              true,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Color(int.parse(checkOutColor)),
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              color:
                                  Color(int.parse(checkOutColor)),
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                dateWiseReport?.checkOut ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Visibility(
                            visible: dateWiseReport
                                    ?.remoteModeOut?.isNotEmpty ==
                                true,
                            child: InkWell(
                              onTap: () {
                                getLocationOutDaily(dateWiseReport);
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
                                    remoteModeOut ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dateWiseReport
                                    ?.checkOutReason?.isNotEmpty ==
                                true,
                            child: InkWell(
                              onTap: () {
                                getReasonOutDaily(dateWiseReport);
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
                height: 16,
              ),
            ],
          );
        },
      )
    );
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

  void getLocationInDaily(DateWiseReport? dateWiseReport) {
    Fluttertoast.showToast(
        msg: dateWiseReport?.checkInLocation ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getLocationOutDaily(DateWiseReport? dateWiseReport) {
    Fluttertoast.showToast(
        msg: dateWiseReport?.checkInLocation ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getReasonInDaily(DateWiseReport? dateWiseReport) {
    Fluttertoast.showToast(
        msg: dateWiseReport?.checkInReason ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  void getReasonOutDaily(DateWiseReport? dateWiseReport) {
    Fluttertoast.showToast(
        msg: dateWiseReport?.checkOutReason ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }
}

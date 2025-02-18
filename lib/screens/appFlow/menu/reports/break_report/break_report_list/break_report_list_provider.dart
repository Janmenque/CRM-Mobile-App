import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/report_response/break_response/break_report_list.dart';
import 'package:hrm_app/data/server/respository/report_repository/break_repository/break_repository.dart';

class BreakReportListProvider extends ChangeNotifier {
  BreakReportListResponse? responseBreakReport;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  int? totalBreak;
  List<TodayHistory>? todayBreakList = [];
  int page = 1;

  int? id;
  String? selectedDate;
  Map<String,dynamic>? data;

  BreakReportListProvider(userId, date) {
    id = userId;
    selectedDate = date;
    data = {'user_id': userId, 'date': date};
    breakReportHistory();
  }

  void breakReportHistory() async {
    var apiResponse = await BreakReportRepository.breakReportHistory(data: data);
    if (apiResponse.result == true) {
      responseBreakReport = apiResponse.data;
      todayBreakList!.addAll(responseBreakReport!.data!.breakHistory!.todayHistory!);
      totalBreak = responseBreakReport?.data?.breakHistory?.pagination?.total;
      isLoading = true;
      notifyListeners();

    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  fetchBreakMoreData() async {
    if (todayBreakList!.length < totalBreak!) {

      isLoading = true;
      final response = await BreakReportRepository.breakReportHistory(data: data, pagination: '?page=${++page}');
      responseBreakReport = response.data;
      todayBreakList!.addAll(responseBreakReport!.data!.breakHistory!.todayHistory!);
      isLoading = false;
      notifyListeners();
    }
  }

  scrollListener({@required isLoading}) {
    scrollController.addListener(() {
      try {
        ///calculate trigger position when api will call, so we want to call api before going
        ///full end we user 0.80 * maxPosition so now api will call little early
        double triggerFetchMoreSize =
            0.75 * scrollController.position.maxScrollExtent;

        if (scrollController.position.pixels > triggerFetchMoreSize) {
          if (isLoading == false) {
            fetchBreakMoreData();
            notifyListeners();
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }
}

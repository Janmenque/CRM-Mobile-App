import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/timesheet/approve_hours_list_model.dart';
import 'package:hrm_app/data/model/timesheet/hourly_statistics_list_model.dart';
import 'package:hrm_app/data/model/timesheet/monthly_overview_model.dart';
import 'package:hrm_app/data/model/timesheet/resource_plan_list_model.dart';
import 'package:hrm_app/data/model/timesheet/schedule_overview_model.dart';
import 'package:hrm_app/data/model/timesheet/time_sheet_report_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import '../../../../api_service/api_response.dart';

class CrmTimesheetRepository {

  ///timesheet list
  static Future<ApiResponse<TimesheetListModel>> getTimesheetList(int? employeeId, String? date) async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets?employee_id=$employeeId&date=$date");
      if (response.statusCode == 200) {
        var obj = timesheetListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = timesheetListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = timesheetListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///timesheet related data
  static Future<ApiResponse<TimesheetRelatedDataModel>> getTimesheetRelatedData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/related-data");
      if (response.statusCode == 200) {
        var obj = timesheetRelatedDataModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = timesheetRelatedDataModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = timesheetRelatedDataModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///timesheet task data
  static Future<ApiResponse<TimesheetTaskListModel>> getTimesheetTaskData(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/new-list?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = timesheetTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = timesheetTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = timesheetTaskListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///clientList
  static Future<ApiResponse<ClientListModel>> getCrmClientList() async {
    try {
      var response = await ApiService.getDio()!.get("/app/clients/list");
      if (response.statusCode == 200) {
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = clientListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///create time sheet
  static Future createTimeSheet(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/time-sheets", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///monthly overview
  static Future<ApiResponse<MonthlyOverviewModel>>getMonthlyOverview(String month, List<TimesheetEmployee>employeeList) async {
    try {

      final employeeIds = employeeList.map((e) => 'employee_id[]=${e.id}').join('&');

      final url = "/app/time-sheets/monthly-overview?month=$month&$employeeIds";

      var response = await ApiService.getDio()!.get(url);
      if (response.statusCode == 200) {
        var obj = monthlyOverviewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = monthlyOverviewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = monthlyOverviewModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///schedule overview
  static Future<ApiResponse<ScheduleOverviewModel>> getScheduleOverviewData(String? startDate, String? endDate, int? projectID, int? employeeId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/schedule-overview?from=$startDate&to=$endDate&project_id=$projectID&employee_id=$employeeId");
      if (response.statusCode == 200) {
        var obj = scheduleOverviewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = scheduleOverviewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = scheduleOverviewModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///Approval Hour
  static Future<ApiResponse<ApproveHourListModel>> getApproveHoursData(String? startDate, String? endDate, int? projectID, int? employeeId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/approve-hours?from=$startDate&to=$endDate&project_id=$projectID&employee_id=$employeeId");
      if (response.statusCode == 200) {
        var obj = approveHourListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = approveHourListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = approveHourListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///Hourly Statics
  static Future<ApiResponse<HourlyStaticsListModel>> getHourlyStaticsData(String? startDate, String? endDate, int? employeeId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/hourly-statistics?from=$startDate&to=$endDate&employee_id=$employeeId");
      if (response.statusCode == 200) {
        var obj = hourlyStaticsListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = hourlyStaticsListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = hourlyStaticsListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///timesheet report data
  static Future<ApiResponse<TimesheetReportListModel>> getTimesheetReportData(String? startDate, String? endDate, int? projectId, int taskId, int? employeeId, int clientId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/timesheet-report?from=$startDate&to=$endDate&project_id=$projectId&task_id=$taskId&employee_id=$employeeId&client_id=$clientId");
      if (response.statusCode == 200) {
        var obj = timesheetReportListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = timesheetReportListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = timesheetReportListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }





  ///timesheet resource plan
  static Future<ApiResponse<ResourcePlanListModel>> getTimesheetResourcePlan() async {
    try {
      var response = await ApiService.getDio()!.get("/app/time-sheets/resource-plan");
      if (response.statusCode == 200) {
        var obj = resourcePlanListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = resourcePlanListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = resourcePlanListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///create resource Plan
  static Future createResourcePlan(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/time-sheets/resource-plan", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


}
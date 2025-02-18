import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_approval_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/approval.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/approval_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class ApprovalDetailsProvider extends ChangeNotifier {
  ApprovalProvider? approvalProvider;
  ResponseApprovalDetails? approvalDetails;
  int? serverApprovalId;
  int? serverUserId;
  bool isVisibility = false;

  ApprovalDetailsProvider(int? approvalID, int? userId) {
    serverApprovalId = approvalID;
    serverUserId = userId;
    getApprovalDetails(approvalID, userId);
    notifyListeners();
  }

  getApprovalDetails(int? approvalID, int? userId) async {
    var bodyUserId = BodyUserId(userId: userId);
    var apiResponse =
        await Repository.getApprovalDetails(approvalID, bodyUserId);
    if (apiResponse.result == true) {
      approvalDetails = apiResponse.data;
      if (apiResponse.data?.data?.status == "Active") {
        isVisibility = false;
        notifyListeners();
      } else if (apiResponse.data?.data?.status == "Reject") {
        isVisibility = false;
        notifyListeners();
      } else {
        isVisibility = true;
        notifyListeners();
      }
      notifyListeners();
    } else {}
  }

  approvalOrReject(int? approvedId, int? type, context) async {
    var apiResponse = await Repository.approvalOrReject(approvedId, type);
    if (apiResponse.result == true) {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      getApprovalDetails(serverApprovalId, serverUserId);
      notifyListeners();
      NavUtil.replaceScreen(context, const ApprovalScreen());
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
}

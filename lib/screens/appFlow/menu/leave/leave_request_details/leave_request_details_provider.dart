import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/all_designation_wise_user/all_designation_wise_user.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_all_leave_request_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_summary/leave_summary.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../data/model/home/crm_home_model.dart';

class LeaveRequestDetailsProvider extends ChangeNotifier {
  ResponseLeaveRequestDetails? leaveDetails;
  Members? allUserData;
  bool? isButtonShow;

  late TextEditingController updateNoteController;

  String? attachment;
  File? attachmentPath;

  LeaveRequestDetailsProvider(var leaveRequestDetailsId) {
    leaveRequestDetails(leaveRequestDetailsId);
  }

  Future leaveRequestDetails(requestId) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
    var apiResponse =
        await Repository.leaveRequestDetails(bodyUserId, requestId);
    if (apiResponse.result == true) {
      leaveDetails = apiResponse.data;

      ///when user update request leave
      ///TexteditController hint will be assign previous note
      updateNoteController =
          TextEditingController(text: leaveDetails?.data?.note);
      attachment = leaveDetails?.data?.attachment;
      if (leaveDetails?.data?.status == "Cancel") {
        isButtonShow = false;
      } else {
        isButtonShow = true;
      }
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(apiResponse.data!.message);
      }
    }
  }

  ///when cancel leave request
  Future cancelRequest(requestId, context) async {
    if (leaveDetails!.data!.status!.contains('Cancel')) {
      Fluttertoast.showToast(msg: tr('you_have_already_cancelled'));
    } else {
      var apiResponse = await Repository.cancelRequest(parmas: requestId);
      if (apiResponse.result == true) {
        final message = apiResponse.data;
        Fluttertoast.showToast(msg: message);
        notifyListeners();
        NavUtil.replaceScreen(context, const LeaveSummary());
      } else {
        if (kDebugMode) {
          print(apiResponse.data!.message);
        }
      }
    }
  }

  ///Pick Attachment from Camera and Gallery
  Future<dynamic> updateAttachmentImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachmentPath = File(image!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachmentPath = File(imageGallery!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  /// get data from all team mate screen
  /// AppreciateTeammate screen
  void getAllUserData(BuildContext context) async {
    allUserData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllDesignationWiseUser()),
    );
    notifyListeners();
  }

  Future updateLeaveRequest() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);

    var fileAttachment = attachmentPath?.path.split('/').last;

    var fromData = FormData.fromMap({
      "user_id": userId,
      "substitute_id": allUserData?.id,
      "reason": updateNoteController.text,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
              filename: fileAttachment)
          : attachment,
    });

    final response = await Repository.updateLeaveRequest(
        fromData: fromData, leaveId: leaveDetails!.data!.id);
    if (response.httpCode == 200) {
      Fluttertoast.showToast(msg: '${response.data}');
    } else {
      Fluttertoast.showToast(msg: tr('something_went_wrong'));
    }
  }
}

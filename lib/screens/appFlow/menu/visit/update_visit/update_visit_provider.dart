import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_visit_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';

class UpdateVisitProvider extends ChangeNotifier {
  File? attachmentPath;
  File? imagePath;
  List imageFile = [];
  List? imageListSever = [];
  int? visitDetailsIdServer;
  var visitTitleTextController = TextEditingController();
  var visitDescriptionTextController = TextEditingController();
  String? errorMassage;
  String? titleError;
  VisitDetailsProvider? visitDetailsProvider;

  UpdateVisitProvider(ResponseVisitDetails? responseVisitList) {
    setData(responseVisitList);
  }

  ///set visit details data
  void setData(ResponseVisitDetails? responseVisitList) {
    visitTitleTextController.text = responseVisitList?.data?.title ?? "";
    visitDescriptionTextController.text =
        responseVisitList?.data?.description ?? "";
    visitDetailsIdServer = responseVisitList?.data?.id;
    responseVisitList?.data?.imageListVisit?.map((e) {
      var path = e.filePath;
      imageListSever?.add(path ?? "");
    }).toList();
    notifyListeners();
  }

  ///Pick image from Camera and Gallery
  Future<dynamic> pickImage(BuildContext context) async {
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
            imageFile.add(File(image!.path));
            attachmentPath = File(image.path);
            updateImageVisitApi(attachmentPath);
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
            imageFile.add(File(imageGallery!.path));
            attachmentPath = File(imageGallery.path);
            updateImageVisitApi(attachmentPath);
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

  /// Update Image Visit API
  void updateImageVisitApi(File? file) async {
    var apiResponse =
        await Repository.updateImageVisit(visitDetailsIdServer, file);
    if (apiResponse.result == true) {
      imageListSever?.add(apiResponse.data?.data ?? "");
      Fluttertoast.showToast(
          msg: apiResponse.data?.message ?? "",
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
  void resetTextField() {
    visitTitleTextController.text = "";
    notifyListeners();
  }

  updateVisitApi(context,int? visitId) async {
    var bodyUpdateVisit = BodyUpdateVisit(
        title: visitTitleTextController.text,
        description: visitDescriptionTextController.text,
        id: visitDetailsIdServer);
    var apiResponse = await Repository.updateVisitApi(bodyUpdateVisit);
    if (apiResponse.result == true) {
      Fluttertoast.showToast(
          msg: apiResponse.data?.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      resetTextField();
      notifyListeners();
      NavUtil.replaceScreen(context, const VisitScreen());
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      titleError = apiResponse.error?.laravelValidationError?.title;
      errorMassage = apiResponse.message;
      notifyListeners();
    }
  }
}

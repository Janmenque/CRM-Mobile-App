import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/nav_utail.dart';
import '../crm_clinet_repository/client_repository.dart';

class AddClientProvider extends ChangeNotifier {
  final clientNameController = TextEditingController();
  final clientPhoneNumberController = TextEditingController();
  final clientEmailController = TextEditingController();
  final clientAddressController = TextEditingController();
  final clientDescriptionController = TextEditingController();

  File? imagePath;

  Future addClient(context) async {
    if (imagePath == null) {
      Fluttertoast.showToast(msg: "You have to must add Image");
    }else{
      var fileName = imagePath!.path.split('/').last;
      final data = FormData.fromMap({
        "avatar":
            await MultipartFile.fromFile(imagePath!.path, filename: fileName),
        "name": clientNameController.text,
        "email": clientEmailController.text,
        "phone": clientPhoneNumberController.text,
        "address": clientAddressController.text,
        "description": clientDescriptionController.text,
      });

      final response = await CrmClientRepository.addClient(data);
      if (response['result'] == true) {
        NavUtil.pushAndRemoveUntil(context, const ButtomNavigationBar());
        notifyListeners();
      }
    }
   
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
                maxHeight: 300.h,
                maxWidth: 300.w,
                imageQuality: 90);
            imagePath = File(image!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300.h,
                maxWidth: 300.w,
                imageQuality: 90);
            imagePath = File(imageGallery!.path);
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


}

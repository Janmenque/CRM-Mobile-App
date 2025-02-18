import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_profile_image.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class OfficeTabProvider extends ChangeNotifier {
  String? profileImage;
  File? imagePath;

  OfficeTabProvider() {
    getUserData();
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
            imagePath = File(image!.path);
            updateProfileImage(imagePath);
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
            imagePath = File(imageGallery!.path);
            updateProfileImage(imagePath);
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

  void getUserData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }

  void updateImageData(ResponseProfileImage? imagePath) async {
    if (imagePath != null) {
      await SPUtill.setValue(SPUtill.keyProfileImage, imagePath.data?.avatar);
      profileImage = imagePath.data?.avatar;
      notifyListeners();
    } else {
      profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
      notifyListeners();
    }
  }

  void updateProfileImage(File? file) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var apiResponse = await ProfileRepository.updateProfileImage(userId, file);
    if (apiResponse.result == true) {
      SPUtill.deleteKey(SPUtill.keyProfileImage);
      SPUtill.setValue(SPUtill.keyProfileImage, apiResponse.data?.data?.avatar);
      profileImage = apiResponse.data?.data?.avatar;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(apiResponse.message);
      }
    }
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_blood_group.dart';
import 'package:hrm_app/data/model/response_personal.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/my_account.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class EditPersonalInfoProvider extends ChangeNotifier {
  String? selectedGender;
  DateTime? dateOfBirthDb;
  DateTime? selectedDate;
  String? bloodGroupTypeValue;
  String? selectedMale;
  var phoneTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var nationalityTextController = TextEditingController();
  var nidNumberTextController = TextEditingController();
  var passportNumberTextController = TextEditingController();
  var linkedInTextController = TextEditingController();
  var facebookTextController = TextEditingController();
  var instagramTextController = TextEditingController();
  ResponseBloodGroup? bloodGroupList;
  String? nidPhotoCopyImage;
  File? nidPhotoCopyPath;
  String? passportPhotocopyImage;
  File? passportPhotocopyPath;
  String? phoneError;
  String? errorMessage;
  String? birthDate;

  EditPersonalInfoProvider(ResponsePersonal? personalInfo) {
    setData(personalInfo);
    getBlood();
  }

  ///Pick Passport image from Camera and Gallery
  Future<dynamic> pickPassportImage(BuildContext context) async {
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
            passportPhotocopyPath = File(image!.path);
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
            passportPhotocopyPath = File(imageGallery!.path);
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

  ///Pick Nid image from Camera and Gallery
  Future<dynamic> pickNidImage(BuildContext context) async {
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
            nidPhotoCopyPath = File(image!.path);
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
            nidPhotoCopyPath = File(imageGallery!.path);
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

  /// Select date data of joining function.....
  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            dateOfBirthDb != null ? dateOfBirthDb!.toLocal() : DateTime.now(),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateOfBirthDb = selectedDate!.toLocal();
      notifyListeners();
    }
  }

  /// select gender
  void genderSelectedValue(String val) {
    selectedGender = val;
    notifyListeners();
  }

  /// select gender type
  void genderType(genderValue) {
    if (genderValue == 'Male') {
      selectedMale = "Male";
    } else if (genderValue == 'Female') {
      selectedMale = "Female";
    } else if (genderValue == 'Unisex') {
      selectedMale = "Unisex";
    }
  }

  /// load all data
  void setData(ResponsePersonal? personalInfo) {
    dateOfBirthDb = personalInfo?.data?.birthDateDb;
    selectedGender = personalInfo?.data?.gender;
    phoneTextController.text = personalInfo?.data?.phone ?? "";
    addressTextController.text = personalInfo?.data?.address ?? "";
    nationalityTextController.text = personalInfo?.data?.nationality ?? "";
    nidNumberTextController.text = personalInfo?.data?.nidCardNumber ?? "";
    passportNumberTextController.text =
        personalInfo?.data?.passportNumber ?? "";
    linkedInTextController.text = personalInfo?.data?.linkedinLink ?? "";
    facebookTextController.text = personalInfo?.data?.facebookLink ?? "";
    instagramTextController.text = personalInfo?.data?.instagramLink ?? "";
    bloodGroupTypeValue = personalInfo?.data?.bloodGroup;
    nidPhotoCopyImage = personalInfo?.data?.nidCardId.toString() ?? "";
    passportPhotocopyImage = personalInfo?.data?.passportFile.toString() ?? "";
  }

  /// dropdownMenu for Employee type .....
  void dropdownMenu(String? newValue) {
    bloodGroupTypeValue = newValue;
    notifyListeners();
  }

  /// Get BloodGroup List from API ......
  void getBlood() async {
    var apiResponse = await ProfileRepository.getBloodGroup();
    if (apiResponse.result == true) {
      bloodGroupList = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

//   /// update Personal Info from API
  void updatePersonalInfo(context, File? nidPath, File? passportPath) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var apiResponse = await ProfileRepository.updateEditPersonalInfo(
        userId,
        selectedGender,
        phoneTextController.text,
        dateOfBirthDb?.toLocal().toString().split(" ")[0],
        addressTextController.text,
        nationalityTextController.text,
        nidNumberTextController.text,
        nidPath,
        passportNumberTextController.text,
        passportPath,
        bloodGroupTypeValue,
        linkedInTextController.text,
        facebookTextController.text,
        instagramTextController.text);
    if (apiResponse.result == true) {
      birthDate = apiResponse.data?.data?.birthDate;
      if (kDebugMode) {
        print(apiResponse.data?.message);
      }
      NavUtil.replaceScreen(
          context,
          const MyAccount(
            tabIndex: 1,
          ));
    } else {
      if (apiResponse.httpCode == 422) {
        phoneError = apiResponse.error?.laravelValidationError?.phone;
        errorMessage = apiResponse.message;
        notifyListeners();
      } else if (apiResponse.httpCode == 400) {
        phoneError = apiResponse.error?.laravelValidationError?.phone;
        errorMessage = apiResponse.message;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    }
  }
}

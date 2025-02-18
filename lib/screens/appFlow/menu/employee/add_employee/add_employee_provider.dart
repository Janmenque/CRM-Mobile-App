import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../data/server/respository/profile_repository/profile_repository.dart';
import '../../../navigation_bar/buttom_navigation_bar.dart';

class AddEmployeeProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final departmentController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final skillController = TextEditingController();

  final List skillList = [];

  String? profileImage;
  File? imagePath;

  Department? department;
  Designation? designation;
  ResponseDesignation? designationList;
  ResponseDepartment? departmentList;

  AddEmployeeProvider(){
    getDesignationList();
    getDepartmentList();
  }


  selectDepartment(Department departmentValue) {
    department = departmentValue;
    notifyListeners();
  }

  selectDesignation(Designation designationValue) {
    designation = designationValue;
    notifyListeners();
  }

  addSkill() {
    skillList.add(skillController.text);
    notifyListeners();
  }

  removeSkillFromList(int index) {
    skillList.removeAt(index);
    notifyListeners();
  }


  void getDesignationList() async {
    var apiResponse = await ProfileRepository.getDesignationList();
    if (apiResponse.result == true) {
      designationList = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  void getDepartmentList() async {
    var apiResponse = await ProfileRepository.getDepartmentList();
    if (apiResponse.result == true) {
      departmentList = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }



  Future addEmployee(context) async {
    var fileName = imagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(imagePath!.path, filename: fileName),
      "name": nameController.text,
      "designation": designation!.id,
      "department": department!.id,
      "phone": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "location": locationController.text,
      "about_me": descriptionController.text,
      "skills": skillList.join(',')
    });

    final response = await EmployeeRepository.addEmployee(data);
    if (response['result'] == true) {
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
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
                maxHeight: 300,
                maxWidth: 300,
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
                maxHeight: 300,
                maxWidth: 300,
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

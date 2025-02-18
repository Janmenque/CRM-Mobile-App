import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/employee_model/employee_details_model.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';
import '../../../navigation_bar/buttom_navigation_bar.dart';

class EditEmployeeProvider extends ChangeNotifier {
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

  EmployeeDetailsModel? employeeData;

  List<Department>? departmentsList;
  List<Designation>? designationList;

  EditEmployeeProvider(EmployeeDetailsModel employeeDetails) {
    employeeData = employeeDetails;
    setControllerData(employeeDetails);
    getDepartmentList();
    getDesignationList();
  }

  setControllerData(EmployeeDetailsModel employeeData) {
    nameController.text = employeeData.data?.name ?? '';
    designationController.text = employeeData.data?.designation ?? '';
    departmentController.text = employeeData.data?.department ?? '';
    phoneController.text = employeeData.data?.phone ?? '';
    emailController.text = employeeData.data?.email ?? '';
    locationController.text = employeeData.data?.address ?? '';
    descriptionController.text = employeeData.data?.aboutMe ?? '';

    profileImage = employeeData.data?.avatar;

    skillList.addAll(employeeData.data!.skills!.map((e) => e.name).toList());
  }

  void getDepartmentList() async {
    var apiResponse = await ProfileRepository.getDepartmentList();
    if (apiResponse.result == true) {
      final responseData = apiResponse.data;
      departmentsList = responseData?.data?.departments;
      department = departmentsList?.firstWhere(
          (element) => element.title == employeeData?.data?.department);
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  void getDesignationList() async {
    var apiResponse = await ProfileRepository.getDesignationList();
    if (apiResponse.result == true) {
      final responseData = apiResponse.data;
      designationList = responseData?.data?.designations;
      designation = designationList?.isNotEmpty == true
          ? designationList?.firstWhere(
              (element) => element.title == employeeData?.data?.designation)
          : null;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
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

  Future editEmployee(context) async {
    final data = FormData.fromMap({
      "avatar": imagePath != null
          ? await MultipartFile.fromFile(imagePath!.path)
          : null,
      "id": employeeData!.data!.id,
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

    final response = await EmployeeRepository.editEmployees(data);
    if (response['result'] == true) {
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      Fluttertoast.showToast(msg: response['message']);
      notifyListeners();
    }
  }

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

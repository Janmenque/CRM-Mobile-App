import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/all_designation_wise_user/all_designation_wise_user.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/model/response_employment_type.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/model/response_update_official_info.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/my_account.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import '../../../../../../../data/model/home/crm_home_model.dart';
import 'deartment_list/department_list.dart';
import 'designation_list/designation_list.dart';

class EditOfficialInfoProvider extends ChangeNotifier {
  String? employeeTypeValue;
  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var departmentTextController = TextEditingController();
  var designationTextController = TextEditingController();
  var employeeIdTextController = TextEditingController();
  var gradeTextController = TextEditingController();
  DateTime? selectedDate;
  Members? managerObj;
  Department? departmentObj;
  Designation? designationObj;
  ResponseEmploymentType? employmentTypeObj;
  int? designationId;
  int? departmentId;
  int? managerId;
  String? joiningDate;
  DateTime? joiningDateDb;
  String? employeeType;
  String? nameError;
  String? emailError;
  String? errorMessage;
  String? managerIdError;

  EditOfficialInfoProvider(ResponseOfficialInfo? officialInfo) {
    setData(officialInfo);
    getEmploymentType();
  }

  /// Select date data of joining function.....
  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            joiningDateDb != null ? joiningDateDb!.toLocal() : DateTime.now(),
        firstDate: DateTime(2010, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      joiningDateDb = selectedDate!.toLocal();
      notifyListeners();
    }
  }

  /// dropdownMenu for Employee type .....
  void dropdownMenu(String? newValue) {
    employeeTypeValue = newValue;
    notifyListeners();
  }

  /// load all data from contactor .....
  void setData(ResponseOfficialInfo? officialInfo) {
    joiningDateDb = officialInfo?.data?.joiningDateDb;
    nameTextController.text = officialInfo?.data?.name ?? "";
    emailTextController.text = officialInfo?.data?.email ?? "";
    designationTextController.text = officialInfo?.data?.designation ?? "";
    departmentTextController.text = officialInfo?.data?.department ?? "";
    employeeIdTextController.text = officialInfo?.data?.employeeId ?? "";
    gradeTextController.text = officialInfo?.data?.grade ?? "";
    designationId = officialInfo?.data?.designationId?.toInt();
    departmentId = officialInfo?.data?.departmentId?.toInt();
    managerId = officialInfo?.data?.managerId?.toInt();
    employeeType = officialInfo?.data?.employeeType.toString();
    employeeTypeValue = officialInfo?.data?.employeeType.toString();
    notifyListeners();
  }

  /// get data from manager screen
  void getManagerData(BuildContext context) async {
    managerObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllDesignationWiseUser()),
    );
    managerId = managerObj?.id;
    notifyListeners();
  }

  /// get data from Department screen
  void getDepartmentData(BuildContext context) async {
    departmentObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DepartmentList()),
    );
    departmentId = departmentObj?.id;
    notifyListeners();
  }

  /// get data from designation screen
  void getDesignationData(BuildContext context) async {
    designationObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DesignationList()),
    );
    designationId = designationObj?.id;
    notifyListeners();
  }

  /// EmploymentType list Api.......
  void getEmploymentType() async {
    var apiResponse = await ProfileRepository.getEmploymentTypeList();
    if (apiResponse.result == true) {
      employmentTypeObj = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  void updateOfficialInfo(context) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyEditOfficialInfo = BodyEditOfficialInfo(
        userId: userId,
        name: nameTextController.text,
        email: emailTextController.text,
        designationId: designationId,
        departmentId: departmentId,
        managerId: managerId,
        joiningDateDb: joiningDateDb?.toLocal().toString().split(" ")[0],
        employeeType: employeeTypeValue,
        employeeId: employeeIdTextController.text,
        grade: gradeTextController.text);
    var apiResponse =
        await ProfileRepository.updateOfficialInfo(bodyEditOfficialInfo);
    if (apiResponse.result == true) {
      setUserData(apiResponse.data);
      apiResponse.data?.message.toString();
      NavUtil.replaceScreen(context, const MyAccount());
    } else {
      nameError = apiResponse.error?.laravelValidationError?.name;
      emailError = apiResponse.error?.laravelValidationError?.email;
      managerIdError = apiResponse.error?.laravelValidationError?.managerId;
      errorMessage = apiResponse.message;
      notifyListeners();
    }
  }

  void setUserData(ResponseUpdateOfficalInfo? userName) async {
    await SPUtill.setValue(SPUtill.keyName, userName?.data?.name);
  }
}

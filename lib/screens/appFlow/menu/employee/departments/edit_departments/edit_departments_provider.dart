import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/department_list_model.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';

class EditDepartmentProvider extends ChangeNotifier {
  Department? departmentData;
  final titleController = TextEditingController();

  EditDepartmentProvider(Department departmentDetails) {
    departmentData = departmentDetails;
    setDataController(departmentDetails);
  }

  setDataController(Department departmentDetails) {
    titleController.text = departmentData?.title ?? '';
  }

  postEditDepartmentData(context) async {
    final data = {'title': titleController.text, "id": departmentData!.id};
    final response = await EmployeeRepository.editDepartments(data);
    if (response['result'] == true) {
      Fluttertoast.showToast(
        msg: response['message'],
      );
    }
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/designation_list_model.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';

class EditDesignationProvider extends ChangeNotifier {
  Designation? designationData;
  final titleController = TextEditingController();

  EditDesignationProvider(Designation designationDetails) {
    designationData = designationDetails;
    setDataController(designationDetails);
  }

  setDataController(Designation designationDetails) {
    titleController.text = designationData?.title ?? '';
  }

  postEditDepartmentData(context) async {
    final data = {'title': titleController.text, "id": designationData!.id};
    final response = await EmployeeRepository.editDesignation(data);
    if (response['result'] == true) {
      Fluttertoast.showToast(
        msg: response['message'],
      );
    }
    notifyListeners();
  }
}

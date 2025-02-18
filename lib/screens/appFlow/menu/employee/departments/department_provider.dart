import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_repository/employee_repositoy.dart';
import 'package:hrm_app/data/model/employee_model/department_list_model.dart';

class EmployeeDepartmentListProvider extends ChangeNotifier {

  DepartmentListModel? departmentListModel;

  EmployeeDepartmentListProvider() {
    getDepartment();
  }

  getDepartment() async {
    final response = await CrmEmployeeRepository.getCrmEployeeDermentList();
    if (response.httpCode == 200) {
      departmentListModel = response.data;
    }
    notifyListeners();
  }

  deleteDepartment(id) async{
    final response = await CrmEmployeeRepository.deleteDepartment(id);
    if(response['result'] == true){
      Fluttertoast.showToast(msg: response['message']);
      await getDepartment();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/menu.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/create_project/create_project_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/update_project/update_project_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../crm_project_repository/crm_project_repository.dart';

class ProjectDetailsProvider extends ChangeNotifier {
  bool? isAdmin;
  int? projectId;

  ProjectDetailsProvider(int? id) {
    projectId = id;
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;
      notifyListeners();
    }
  }

  menuItemRoute(value, context, ProjectDetails details) {
    switch (value) {
      case "update":
        return NavUtil.navigateScreen(
            context,
            ChangeNotifierProvider(
                create: (context) {
                  return CrmCreateProjectProvider(details: details);
                },
                child: UpdateProjectScreen(
                  details: details,
                )));
      case "delete":
        return projectDelete(projectId, context);
      default:
    }
  }

  ///project delete
  projectDelete(id, context) async {
    final response = await CrmProjectRepository.projectDelete(projectId: id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Project Deleted Successfully");
      NavUtil.navigateScreen(context,  MenuScreen());
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!!");
    }
  }
}

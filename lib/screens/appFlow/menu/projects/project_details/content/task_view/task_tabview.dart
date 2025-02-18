import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_view/task_item.dart';
import '../../../../clients/model/project_details_model.dart';

class TaskTabView extends StatelessWidget {
  final ProjectDetails? project;

  const  TaskTabView({Key? key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
      shrinkWrap: true,
      itemCount: project?.tasks?.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TaskItem(task: project?.tasks?.elementAt(index));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/feedback_item.dart';
import '../../../clients/model/project_details_model.dart';

class FeedbackTabView extends StatelessWidget {
  final ProjectDetails? project;

  const FeedbackTabView({Key? key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
      shrinkWrap: true,
      itemCount: project?.feedbacks?.length,
      itemBuilder: (BuildContext context, int index) {
        return FeedbackItem(
          feedback: project?.feedbacks?.elementAt(index),
          projectId: project!.id!,
        );
      },
    );
  }
}

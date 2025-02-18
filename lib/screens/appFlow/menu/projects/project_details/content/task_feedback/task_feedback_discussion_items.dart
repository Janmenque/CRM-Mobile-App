import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_feedback/task_feedback_discussion_item.dart';
import '../../../../task/model/task_details_model.dart';


class TaskFeedbackDiscussionItems extends StatelessWidget {

  final List<Discussion>? discussions;

  const TaskFeedbackDiscussionItems({Key? key,this.discussions}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shrinkWrap: true,
      itemCount: discussions?.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TaskFeedbackDiscussionItem(discussion: discussions?.elementAt(index));
      },
    );
  }
}

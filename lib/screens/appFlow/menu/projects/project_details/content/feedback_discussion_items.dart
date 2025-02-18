import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../clients/model/project_details_model.dart';
import 'feedback_discussion_item.dart';


class FeedbackDiscussionItems extends StatelessWidget {

  final List<Discussion>? discussions;
  final int projectId;

  const FeedbackDiscussionItems({Key? key,this.discussions, required this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shrinkWrap: true,
      itemCount: discussions?.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return FeedbackDiscussionItem(discussion: discussions?.elementAt(index), projectId: projectId,);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_attachment_list.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_feedback/task_feedback_list.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'feedback_discussion_items.dart';

class FeedbackItem extends StatelessWidget {
  final ProjectFeedback? feedback;
  final int projectId;

  const FeedbackItem({Key? key, this.feedback, required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> assigns = [];

    for (int i = 0; i < feedback!.projectDetailsMembers!.length; i++) {
      assigns.add(Positioned(
        left: i * 15,
        top: 0.0,
        bottom: 0.0,
        child: Container(
          width: 25.0.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      '${feedback!.projectDetailsMembers!.elementAt(i).avatar}'))),
          child: const SizedBox.shrink(),
        ),
      ));
    }

    var commentCount;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xffF8F8F8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.sp),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: feedback!.isCompleted!
                                  ? Colors.green
                                  : Colors.grey,
                            )),
                        child: Icon(
                          Icons.check,
                          color: feedback!.isCompleted!
                              ? Colors.green
                              : Colors.grey,
                          size: 12.sp,
                        ),
                      ),
                      SizedBox(
                        width: 8.0.w,
                      ),
                      Expanded(
                        child: Text(
                          '${feedback?.name}',
                          style: const TextStyle(
                              color: Color(0xff555555),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 16.0.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/projects/task_chat_calender.png",
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              '${feedback?.date}',
                              style: TextStyle(
                                  color: const Color(0xff777777),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            commentCount = NavUtil.navigateScreen(
                                context,
                                TaskFeedbackListScreen(
                                    taskId: feedback?.id ?? 0));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/projects/chat_color.png",
                                height: 20.h,
                                width: 20.w,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '${feedback?.discussionCount}',
                                // '$commentCount}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            NavUtil.navigateScreen(
                                context,
                                AttachmentListScreen(
                                    taskId: feedback?.id ?? 0));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/projects/task_file.png",
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '${feedback?.fileCount}',
                                style: TextStyle(
                                    color: const Color(0xff777777),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 90,
                          height: 39,
                          child: Center(child: Stack(children: assigns)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0.w),
            child: FeedbackDiscussionItems(
              discussions: feedback!.discussions,
              projectId: projectId,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffEBEBEB)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                children: [
                  TextField(
                    maxLines: 2,
                    cursorColor: const Color(0xff5B58FF),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: const Color(0xff8A8A8A),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                        hintText: "Reply or post an update"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Aa",
                                style: TextStyle(
                                    color: const Color(0xff828282),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 12.w,
                            ),
                            Image.asset(
                              "assets/projects/happy-outline.png",
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Image.asset(
                              "assets/projects/task_file.png",
                              height: 20.h,
                              width: 20.w,
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6152BE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              minimumSize: Size(58.w, 28.h),
                            ),
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

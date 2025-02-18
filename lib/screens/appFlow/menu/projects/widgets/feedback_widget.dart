import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../task/model/task_details_model.dart';
import '../project_details/content/task_feedback/task_feedback_discussion_items.dart';

class FeedBackWidget extends StatelessWidget {
    const FeedBackWidget({super.key, required this.onTap,  required this.taskDetails, required this.commentController, this.onChanged});
   final TaskDetails? taskDetails;
   final TextEditingController commentController;
   final Function()? onTap;
    final Function(String)? onChanged;



  @override
  Widget build(BuildContext context) {
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
                              color: Colors.grey,
                            )),
                        child: Icon(
                          Icons.check,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ),
                      SizedBox(
                        width: 8.0.w,
                      ),
                      Expanded(
                        child: Text(
                          taskDetails?.title ?? "",
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
                              taskDetails?.date ?? "",
                              style: TextStyle(
                                  color: const Color(0xff777777),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
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
                              
                              '${taskDetails?.discussionsCount}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
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
                              
                              '${taskDetails?.filesCount}',
                              style: TextStyle(
                                  color: const Color(0xff777777),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
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
            child:  TaskFeedbackDiscussionItems(discussions:taskDetails?.discussion ),
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
                    maxLines: 3,
                    onChanged: onChanged,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: onTap,
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

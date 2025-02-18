import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_attachment_list.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/content/task_feedback/task_feedback_list.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class TaskItem extends StatefulWidget {
  final ProjectTasks? task;

  const TaskItem({Key? key, this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {


    int commentCount = widget.task!.discussions!;

    List<Widget> assigns = [];

    for (int i = 0; i < widget.task!.projectDetailsMembers!.length; i++) {
      assigns.add(Positioned(
        left: i * 15,
        top: 0.0,
        bottom: 0.0,
        child: Container(
          width: 25.0.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:
                      NetworkImage('${widget.task!.projectDetailsMembers!.elementAt(i).avatar}'))),
          child: const SizedBox.shrink(),
        ),
      ));
    }

    if (kDebugMode) {
      print('comment count $commentCount');
    }

    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r), color: Colors.white),
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
                        color: widget.task!.isCompleted! ? Colors.green : Colors.grey),
                  ),
                  child: Icon(
                    Icons.check,
                    color: widget.task!.isCompleted! ? Colors.green : Colors.grey,
                    size: 12.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    '${widget.task?.name}',
                    style: const TextStyle(
                        color: Color(0xff555555),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 18.w,
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
                        '${widget.task?.date}',
                        style: TextStyle(
                            color: const Color(0xff777777),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async{
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  TaskFeedbackListScreen(taskId: widget.task?.id ?? 0)),
                      );
                      if (kDebugMode) {
                        print(commentCount);
                      }
                      setState(() {
                        commentCount = result;
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/projects/task_message.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          '$commentCount',
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
                  child: InkWell(
                    onTap: () {
                      NavUtil.navigateScreen(
                          context, AttachmentListScreen(taskId: widget.task?.id ?? 0));
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
                        Text(
                          '${widget.task?.files}',
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
                  flex: 1,
                  child: SizedBox(
                    height: 40.0.h,
                    child: Center(child: Stack(children: assigns)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_provider.dart';
import 'package:provider/provider.dart';
import '../../../../task/model/task_details_model.dart';

class TaskFeedbackDiscussionItem extends StatelessWidget {

  final Discussion? discussion;

  const TaskFeedbackDiscussionItem({Key? key, this.discussion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrmTaskDetailsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30.0.w,
              height: 30.0.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage('${discussion?.avatar}'))
              ),
              child: const SizedBox.shrink(),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text('${discussion?.createdBy}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '${discussion?.description}',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                        color: const Color(0xff4F4F4F),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    children: [
                      Text(
                        '${discussion?.createdAt}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color:
                            const Color(0xff828282),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6.0,),
                      Text(
                        '${discussion?.likesCount}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color:
                            const Color(0xff2F80ED),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6.0,),
                      Icon(
                        Icons.thumb_up,
                        size: 12.sp,
                        color: discussion!.alreadyLiked! ? Colors.blue : Colors.grey,
                      ),
                       const SizedBox(width: 6.0,),
                       InkWell(
                         onTap: (){
                           provider.commentDelete(discussion!.id);
                         },
                           child: Icon(Icons.delete_forever,  size: 12.sp,color : Colors.grey))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

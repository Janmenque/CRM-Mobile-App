import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';

class FeedbackDiscussionItem extends StatefulWidget {
  final Discussion? discussion;
  final int projectId;

  const FeedbackDiscussionItem(
      {Key? key, this.discussion, required this.projectId})
      : super(key: key);

  @override
  State<FeedbackDiscussionItem> createState() => _FeedbackDiscussionItemState();
}

class _FeedbackDiscussionItemState extends State<FeedbackDiscussionItem> {
  Future commentDelete(id) async {
    final response =
        await CrmTaskRepository.feedbackCommentDelete(commentId: id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: response['message']);
      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  image: DecorationImage(
                      image: NetworkImage('${widget.discussion?.avatar}'))),
              child: const SizedBox.shrink(),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.discussion?.createdBy}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '${widget.discussion?.description}',
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
                        '${widget.discussion?.createdAt}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: const Color(0xff828282),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        '${widget.discussion?.likeCount}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: const Color(0xff2F80ED),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Icon(
                        Icons.thumb_up,
                        size: 12.sp,
                        color: widget.discussion!.liked!
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Icon(Icons.edit_outlined,
                              size: 12.sp, color: Colors.grey)),
                      const SizedBox(
                        width: 4.0,
                      ),
                      InkWell(
                          onTap: () async {
                            final response =
                                await commentDelete(widget.discussion!.id);
                            if (response['result'] == true) {
                              setState(() {
                                CrmClientRepository.getProjectDetailsData(
                                    id: widget.projectId);
                                if (kDebugMode) {
                                  print('click');
                                }
                              });
                            }
                          },
                          child: Icon(Icons.delete_forever,
                              size: 12.sp, color: Colors.grey))
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

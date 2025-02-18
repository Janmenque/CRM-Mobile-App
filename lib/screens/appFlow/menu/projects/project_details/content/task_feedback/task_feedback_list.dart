import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:provider/provider.dart';
import '../../../widgets/feedback_widget.dart';

class TaskFeedbackListScreen extends StatefulWidget {
  final int taskId;

  const TaskFeedbackListScreen({super.key, required this.taskId});

  @override
  State<TaskFeedbackListScreen> createState() => _TaskFeedbackListScreenState();
}

final formKey = GlobalKey<FormState>();

class _TaskFeedbackListScreenState extends State<TaskFeedbackListScreen> {

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
        child: ChangeNotifierProvider(
          create: ((context) => CrmTaskDetailsProvider(widget.taskId)),
          child: Consumer<CrmTaskDetailsProvider>(builder: (context, provider, _) {
            return Scaffold(
                backgroundColor: const Color(0xffF5F6FA),
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    "Feedback List",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context, 10);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                body:
                provider.crmTaskDetailsResponse?.data?.taskDetails?.members != null ?
                Form(
                  key: formKey,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 14.w),
                    shrinkWrap: true,
                    itemCount: provider.crmTaskDetailsResponse?.data?.taskDetails?.files?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = provider.crmTaskDetailsResponse?.data?.taskDetails;
                            return FeedBackWidget(
                              taskDetails: data,
                              commentController: provider.commentController,
                              onChanged: (value){
                                debugPrint('value $value');
                                setState(() {
                                  provider.commentController.value = TextEditingValue(
                                      text: value,
                                      selection: TextSelection(
                                          baseOffset: value.length,
                                          extentOffset: value.length)
                                  );
                                });
                              },
                              onTap: () {
                                setState(() {
                                  if (formKey.currentState!.validate()) {
                                    provider.feedbackComment(context);
                                    provider.commentController.clear();
                                  }
                                });
                              },
                            );
                          },
                        ),
                      )
                    : const CustomListShimer());
          }),
        ));
  }
}

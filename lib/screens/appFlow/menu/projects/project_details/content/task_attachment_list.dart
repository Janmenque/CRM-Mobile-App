import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/widgets/attachment_widget.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:provider/provider.dart';

class AttachmentListScreen extends StatelessWidget {
  final int taskId;

  const AttachmentListScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
        child: ChangeNotifierProvider(
      create: ((context) => CrmTaskDetailsProvider(taskId)),
      child: Consumer<CrmTaskDetailsProvider>(builder: (context, provider, _) {
        return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Attachment List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            body: provider.crmTaskDetailsResponse?.data?.taskDetails?.files !=
                    null
                ? ListView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
                    shrinkWrap: true,
                    itemCount: provider.crmTaskDetailsResponse?.data
                        ?.taskDetails?.files?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = provider.crmTaskDetailsResponse?.data
                          ?.taskDetails?.files?[index];
                      Files file = Files(
                          id: data?.id,
                          attachment: data?.attachment,
                          logo: data?.fileLogo,
                          title: data?.title,
                          createdBy: data?.createdBy);
                      return AttachmentListWidget(
                        attachmentImage: data?.attachment,
                        title: data?.title,
                        createdBy: data?.createdBy,
                        file: file,
                      );
                    },
                  )
                : const CustomListShimer());
      }),
    ));
  }
}

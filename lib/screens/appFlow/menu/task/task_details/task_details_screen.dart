import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/edit_task/edit_task_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/custom_widgets/progress_indecator_with_persentage.dart';
import 'package:hrm_app/screens/custom_widgets/task_details_shimmer.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskId;
  final int? index;
  final CrmTaskListProvider taskListProvider;

  const TaskDetailsScreen({super.key, required this.taskId, this.index, required this.taskListProvider});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmTaskDetailsProvider(taskId),
        child:
            Consumer<CrmTaskDetailsProvider>(builder: (context, provider, _) {
          final data = provider.crmTaskDetailsResponse?.data?.taskDetails;

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  if(data != null){
                    provider.taskDetailsInfo(index: index ?? 0, taskDetailsData: data, taskListProvider: taskListProvider);
                  }
                  Navigator.pop(context, index, );
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "task_details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ).tr(),
              actions: [
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () {
                      NavUtil.replaceScreen(
                          context,
                          EditTaskScreen(
                            taskDetails: provider.crmTaskDetailsResponse,
                            taskId: taskId,
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.colorPrimary),
                      child: Icon(
                        size: 14.0.r,
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(taskId);
                      }
                      provider.taskDelete(taskId, context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.colorPrimary),
                      child: Icon(
                        size: 14.0.r,
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: provider.crmTaskDetailsResponse?.data?.taskDetailsMembers !=
                    null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TitleAndValueRow(
                                  title: "Task Name : ".tr(),
                                  value: data?.title ?? ""),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          ).tr(),
                          Text(
                            maxLines: 5,
                            data?.description ?? "",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: const Color(0xff8A8A8A),
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TitleAndValueRow(
                              title: "Priority : ".tr(),
                              value: data?.priority ?? ""),
                          SizedBox(
                            height: 16.h,
                          ),
                          TitleAndValueRow(
                            title: "Task Supervisor : ".tr(),
                            value: data?.supervisor ?? "",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deadline",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              data?.status == "In Progress"
                                  ? InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: Text("${data?.title} "),
                                            content: const Text(
                                                "Is Your Task Complete ? "),
                                            actions: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.colorPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: InkWell(
                                                  onTap: () =>
                                                     provider.getTaskStatus(data?.id, context),
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.colorPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: InkWell(
                                                  onTap: () => Navigator.pop(
                                                      context, 'No'),
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.colorPrimary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "Task Status",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "Task Complete",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Image.asset(
                                          "assets/task/check.png",
                                          height: 24.h,
                                          width: 24.w,
                                        )
                                      ],
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/projects/light_calender_new.png",
                                height: 44.h,
                                width: 44.w,
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              Text(
                                data?.startDate ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              Image.asset(
                                "assets/projects/dark_calender.png",
                                height: 44.h,
                                width: 44.w,
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              Text(
                                data?.endDate ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ProgressIndeccatorWithPersentage(
                            persentageActiveColor: const Color(0xff615FFF),
                            persentageDisebleColor: const Color(0xffC9C9C9),
                            activeContainerWidth: ((ScreenUtil
                                            .defaultSize.width -
                                        80.0) *
                                    double.parse('${data?.progress ?? 0}')) /
                                100,
                            deActivetContainerWidth:
                                (ScreenUtil.defaultSize.width - 80.0) -
                                    ((ScreenUtil.defaultSize.width - 85.0) *
                                            double.parse(
                                                '${data?.progress ?? 0}')) /
                                        100,
                            containerHeight: 12.h,
                            persentage: "${data?.progress ?? 0}%",
                            persentageTextHeight: 16.h,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            "assignee",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: const Color(0xff8A8A8A),
                                fontSize: 14.sp),
                          ).tr(),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            children: provider.crmTaskDetailsResponse?.data
                                        ?.taskDetailsMembers.isNotEmpty ==
                                    true
                                ? provider.crmTaskDetailsResponse!.data!
                                    .taskDetailsMembers
                                    .map((e) => Stack(
                                          children: [
                                            Positioned(
                                                child: InkWell(
                                              onTap: () {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text(
                                                        "Name : ${e.name} "),
                                                    content: Text(
                                                        "Designation : ${e.designation ?? ""} \nDepertment : ${e.department ?? ""} \nPhone : ${e.phone ?? ""}"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 36.0.h,
                                                width: 36.0.w,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e.avatar!),
                                                        fit: BoxFit.cover),
                                                    shape: BoxShape.circle),
                                              ),
                                            ))
                                          ],
                                        ))
                                    .toList()
                                : [],
                          )
                        ],
                      ),
                    ),
                  )
                : const TaskDetailsShimmerEffect(),
          );
        }),
      ),
    );
  }
}

class TitleAndValueRow extends StatelessWidget {
  const TitleAndValueRow({Key? key, this.title, this.value, this.maxLine})
      : super(key: key);

  final String? title, value;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp),
        ).tr(),
        Text(
          maxLines: 5,
          value ?? "",
          textAlign: TextAlign.justify,
          style: TextStyle(color: const Color(0xff8A8A8A), fontSize: 14.sp),
        ),
      ],
    );
  }
}

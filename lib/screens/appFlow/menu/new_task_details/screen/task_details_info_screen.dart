
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/provider/task_info_provider.dart';
import 'package:hrm_app/screens/custom_widgets/progress_indecator_with_persentage.dart';
import 'package:hrm_app/screens/custom_widgets/task_details_shimmer.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class TaskDetailsInfoScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailsInfoScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInfoProvider>(builder: (context, provider, _) {
      final data = provider.crmTaskDetailsResponse?.data?.taskDetails;
      return Scaffold(
        body: provider.crmTaskDetailsResponse?.data?.taskDetailsMembers != null ? SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                    data?.isCompleted != true
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
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.colorPrimary,
                            ),
                            borderRadius:
                            BorderRadius.circular(5)),
                        child: Text(
                          "Update Task Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp),
                        ),
                      ),
                    )
                        : Row(
                      children: [
                        Image.asset(
                          "assets/task/check.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Task Complete",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                margin: const EdgeInsets.symmetric( horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child:  Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Task Name", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Status", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Priority", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Project", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Supervisor", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Start Date", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 4,),
                            Text("Deadline", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 6,),
                            Text("Progress", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                            SizedBox(height: 8,),

                          ],
                        ),),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(": ${data?.title ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.status ?? ""}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: data?.isCompleted == true ? AppColors.colorPrimary :Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.priority ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.project ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.supervisor ?? ""}", style:  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.startDate ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 4,),
                          Text(": ${data?.endDate ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 6,),
                          ProgressIndeccatorWithPersentage(
                            persentageActiveColor: const Color(0xff615FFF),
                            persentageDisebleColor: const Color(0xffC9C9C9),
                            activeContainerWidth: ((ScreenUtil.defaultSize.width - 80.0) * double.parse('${data?.progress ?? 0}')) / 100,
                            deActivetContainerWidth:
                            (ScreenUtil.defaultSize.width - 80.0) - ((ScreenUtil.defaultSize.width - 85.0) * double.parse('${data?.progress ?? 0}')) / 100,
                            containerHeight: 12.h,
                            persentage: "${data?.progress ?? 0}%",
                            persentageTextHeight: 16.h,
                          ),
                          const SizedBox(height: 8,),

                        ],
                      ),),
                  ],
                ),
              ),
              const SizedBox(height: 14,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                margin: const EdgeInsets.symmetric( horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Assign Members", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6F767E)),),
                    const SizedBox(height: 8,),
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
            ],
          ),
        )
            : const TaskDetailsShimmerEffect(),
      );
    });
  }
}
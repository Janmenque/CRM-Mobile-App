import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/new_task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/completed_task/completed_task_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/create_task/create_task_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_deshboard/task_dashboard_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/complete_task_card.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/task_dashboard_card.dart';
import 'package:hrm_app/screens/custom_painer_design/painer_dask_dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard_shimer_effect.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../../utils/nav_utail.dart';
import 'content/task_assign_card_with_date.dart';

class TaskDashboardScreen extends StatelessWidget {
  const TaskDashboardScreen({super.key});

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0XFF004D96),
                          Color(0XFF0082FF),
                        ]),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600]),
                ).tr()
              ]),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmTaskProvider(),
        child: Consumer<CrmTaskProvider>(builder: (context, provider, _) {
          final statistics =
              provider.crmTaskDashboardResponse?.data?.staticstics;
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Tasks',
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ).tr(),
              actions: [
                Visibility(
                  visible: provider.isAdmian ?? false,
                  child: PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: AppColors.black,
                    ),
                    onSelected: (value) {
                      menuItemRoute(value, context);
                    },
                    itemBuilder: (BuildContext context) => [
                      _buildPopupMenuItem('add_task'),
                    ],
                  ),
                )
              ],
            ),
            body: Visibility(
              visible:
                  provider.crmTaskDashboardResponse?.data?.staticstics != null,
              replacement: const DashboardShimerEffect(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          TaskDashboardCard(
                            ontap: () {
                              if (kDebugMode) {
                                print("total task card");
                              }
                              NavUtil.navigateScreen(
                                  context,
                                  TaskListScreen(
                                      taskId: statistics?[0].status));
                            },
                            customPainter: TotalTasklCustomPainter(),
                            title: statistics?[0].text,
                            count: statistics?[0].count.toString(),
                            titleAsset: "assets/task/task.png",
                            titileColor: const Color(0xffD8808F),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          TaskDashboardCard(
                            ontap: () => NavUtil.navigateScreen(
                                context,
                                TaskListScreen(
                                  taskId: statistics?[1].status,
                                )),
                            customPainter: TotalCompleteTasklCustomPainter(),
                            title: statistics?[1].text,
                            count: statistics?[1].count.toString(),
                            titleAsset: "assets/task/complete_task.png",
                            titileColor: const Color(0xff80C090),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TaskDashboardCard(
                            ontap: () => NavUtil.navigateScreen(
                                context,
                                TaskListScreen(
                                  taskId: statistics?[2].status,
                                )),
                            customPainter: TotalTaskInProgresslCustomPainter(),
                            title: statistics?[2].text,
                            count: statistics?[2].count.toString(),
                            titleAsset: "assets/task/task_in_progress.png",
                            titileColor: const Color(0xffD3B980),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          TaskDashboardCard(
                            ontap: () => NavUtil.navigateScreen(
                                context,
                                TaskListScreen(
                                  taskId: statistics?[3].status,
                                )),
                            customPainter: TotalTaskInReviewCustomPainter(),
                            title: statistics?[3].text,
                            count: statistics?[3].count.toString(),
                            titleAsset: "assets/task/task_in_review.png",
                            titileColor: const Color(0xff80BBC3),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      ///title and see all burron card
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Task in Progress",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ).tr(),
                            InkWell(
                              onTap: () {
                                NavUtil.navigateScreen(
                                    context, const TaskListScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 8.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff5B58FF)),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  "see_all",
                                  style: TextStyle(
                                      color: const Color(0xff5B58FF),
                                      fontSize: 14.sp),
                                ).tr(),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2.h,
                      ),

                      ///task in_progree list from api response
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.crmTaskDashboardResponse?.data
                              ?.tasksInCollection?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = provider.crmTaskDashboardResponse?.data
                                ?.tasksInCollection?[index];
                            return TaskAssignCardWithDate(
                              onTap: () {
                                NavUtil.navigateScreen(
                                  context,
                                  NewTaskDetailsScreen(taskId: data!.id!),
                                );
                              },
                              userCount: data?.usersCount,
                              userData: data,
                              taskName: data?.title,
                              tapButtonColor: const Color(0xff5B58FF),
                              taskStartDate: data?.dateRange,
                            );
                          }),

                      ///complete task title
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white),
                        child: Column(
                          children: [
                            //title and see all
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Completed Task",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ).tr(),
                                InkWell(
                                  onTap: () {
                                    NavUtil.navigateScreen(context,
                                        const CompleteTaskListScreen());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff5B58FF)),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      "see_all",
                                      style: TextStyle(
                                          color: const Color(0xff5B58FF),
                                          fontSize: 14.sp),
                                    ).tr(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      provider.crmTaskDashboardResponse?.data
                                  ?.tasksInCollection ==
                              null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white),
                              child: Center(
                                  child: Text(
                                "No Task Found Yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.crmTaskDashboardResponse?.data
                                      ?.completeTasksCollection?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider.crmTaskDashboardResponse
                                    ?.data?.completeTasksCollection?[index];
                                return CompleteTaskCard(
                                  onTap: () {
                                    NavUtil.navigateScreen(
                                      context,
                                      NewTaskDetailsScreen(
                                        taskId: data!.id!,
                                      ),
                                    );
                                  },
                                  taskName: data?.title,
                                  completeTaskData: data,
                                  tapbuttonColor: const Color(0xff5B58FF),
                                  seeDetailsText: "See Task Details".tr(),
                                );
                              }),
                      SizedBox(
                        height: 84.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  menuItemRoute(value, context) {
    switch (value) {
      case "add_task":
        return NavUtil.navigateScreen(context, const CreateTaskScreen());
      default:
        if (kDebugMode) {
          print('value miss math');
        }
    }
  }
}

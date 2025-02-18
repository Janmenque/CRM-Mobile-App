import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_task_details/screen/new_task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/completed_task/complete_task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/complete_list_task_card.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class CompleteTaskListScreen extends StatelessWidget {
  const CompleteTaskListScreen({Key? key, this.taskId}) : super(key: key);

  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CompleteTaskListProvider(statusId: taskId),
        child:
            Consumer<CompleteTaskListProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Complete Task List',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13.5.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: TextFormField(
                            onChanged: ((value) {
                              provider.getSearchValue(value);
                            }),
                            maxLines: 1,
                            cursorColor: const Color(0xff5B58FF),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                hintStyle: TextStyle(
                                    color: const Color(0xffCED1DA),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                                hintText: "Search...."),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Visibility(
                    visible: taskId == '0',
                    replacement: const SizedBox.shrink(),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Task in Progress",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          ///tapBar button
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTapBarButtonWithQuantity(
                                      onTap: () {
                                        provider.changeTaskStatus('31');
                                      },
                                      buttonColor: const Color(0xffDEDEFF),
                                      buttonText: 'Progress',
                                      textColor: const Color(0xff5B58FF),
                                      circleColor: const Color(0xff5B58FF),
                                      quantity: '18',
                                      verticalPadding: 1.5.h)),
                              SizedBox(
                                width: 8.0.w,
                              ),
                              Expanded(
                                  child: CustomTapBarButtonWithQuantity(
                                      onTap: () {
                                        provider.changeTaskStatus('30');
                                      },
                                      buttonColor: const Color(0xffFFF6E7),
                                      buttonText: 'Priority',
                                      textColor: const Color(0xffEC8E00),
                                      circleColor: const Color(0xffEC8E00),
                                      quantity: '12',
                                      verticalPadding: 1.5.h)),
                              SizedBox(
                                width: 8.0.w,
                              ),
                              Expanded(
                                  child: CustomTapBarButtonWithQuantity(
                                      onTap: () {
                                        provider.changeTaskStatus('29');
                                      },
                                      buttonColor: const Color(0xffFDEFEF),
                                      buttonText: 'Urgent',
                                      textColor: const Color(0xffE96161),
                                      circleColor: const Color(0xffE96161),
                                      quantity: '06',
                                      verticalPadding: 1.5.h)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Visibility(
                    replacement: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil.defaultSize.height / 3,
                        ),
                        const Text(''),
                      ],
                    ),
                    visible: provider.completeTaskListResponse?.data
                            ?.taskListCollection?.tasks?.isEmpty ==
                        false,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.completeTaskListResponse?.data
                                ?.taskListCollection?.tasks?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider.completeTaskListResponse?.data
                              ?.taskListCollection?.tasks?[index];
                          return CompleteListTaskCard(
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
                            seeDetailsText: "See Task Details",
                          );
                        }),
                  )
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}

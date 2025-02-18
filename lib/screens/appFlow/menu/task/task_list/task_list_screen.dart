
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/create_task/create_task_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_contain.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key, this.taskId});

  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: Consumer<CrmTaskListProvider>(builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),
          appBar: AppBar(
            // leading: InkWell(
            //     onTap: (){
            //       Navigator.pop(context);
            //     },
            //     child: const Icon(Icons.arrow_back, color: AppColors.black,)),
            elevation: 0,
            title:  Text('task_list', style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),).tr(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(children: [
              SizedBox(
                height: 20.h,
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
                        controller: provider.searchController,
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
                            hintText: "Search....".tr()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateTaskScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 13.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: const Color(0xff5B58FF),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Icon(
                        Icons.add,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              // Visibility(
              //   visible: taskId == '0',
              //   replacement: const SizedBox.shrink(),
              //   child: Container(
              //     padding:
              //         EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.r),
              //         color: Colors.white),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "Task in Progress",
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w600,
              //               fontSize: 16.sp),
              //         ).tr(),
              //
              //         SizedBox(
              //           height: 20.h,
              //         ),
              //
              //         ///tapBar button
              //         Row(
              //           children: [
              //             Expanded(
              //                 child: CustomTapBarButtonWithQuantity(
              //                     onTap: () {
              //                       provider.changeTaskStatus('31');
              //                     },
              //                     buttonColor: const Color(0xffDEDEFF),
              //                     buttonText: 'Progress'.tr(),
              //                     textColor: const Color(0xff5B58FF),
              //                     circleColor: const Color(0xff5B58FF),
              //                     quantity: '18',
              //                     verticalPadding: 1.5.h)),
              //             SizedBox(
              //               width: 8.0.w,
              //             ),
              //             Expanded(
              //                 child: CustomTapBarButtonWithQuantity(
              //                     onTap: () {
              //                       provider.changeTaskStatus('30');
              //                     },
              //                     buttonColor: const Color(0xffFFF6E7),
              //                     buttonText: 'Priority'.tr(),
              //                     textColor: const Color(0xffEC8E00),
              //                     circleColor: const Color(0xffEC8E00),
              //                     quantity: '12',
              //                     verticalPadding: 1.5.h)),
              //             SizedBox(
              //               width: 8.0.w,
              //             ),
              //             Expanded(
              //                 child: CustomTapBarButtonWithQuantity(
              //                     onTap: () {
              //                       provider.changeTaskStatus('29');
              //                     },
              //                     buttonColor: const Color(0xffFDEFEF),
              //                     buttonText: 'Urgent'.tr(),
              //                     textColor: const Color(0xffE96161),
              //                     circleColor: const Color(0xffE96161),
              //                     quantity: '06',
              //                     verticalPadding: 1.5.h)),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),

              Expanded(child: TaskListContent(provider: provider,))
            ]),
          ),
        );
      }),
    );
  }
}

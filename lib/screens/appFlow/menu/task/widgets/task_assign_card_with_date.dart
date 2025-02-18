import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/home/crm_home_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_dashboard_model.dart';
import '../../../../custom_widgets/custom_tap_bar_button.dart';

class TaskAssignCardWithDate extends StatelessWidget {
  const TaskAssignCardWithDate(
      {Key? key,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.tapButtonColor,
      this.taskEndDate,
      this.taskName,
      this.userData,
        this.userCount,
      required this.onTap,
      this.taskStartDate,
      this.taskListData})
      : super(key: key);

  final String? taskName,
      image1,
      image2,
      image3,
      image4,
      taskStartDate,
      taskEndDate;
  final int? userCount;
  final Datum? userData;
  final Color? tapButtonColor;
  final Function()? onTap;
  final Collection? taskListData;

  @override
  Widget build(BuildContext context) {
    List<Widget> assigns = [];
    final data = userData?.members;
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        assigns.add(Positioned(
          left: i * 15,
          top: 0.0,
          bottom: 0.0,
          child: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                   icon :Container(
                     width: 30.0.w,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             image: NetworkImage('${data.elementAt(i).avatar}'))),
                     child: const SizedBox.shrink(),
                   ),
                  title:  Text("name : ${data.elementAt(i).name}" ).tr(),
                  content: Text("designation : ${data.elementAt(i).designation ?? ""}\nDepartment : ${data.elementAt(i).department ?? ""}\nPhone : ${data.elementAt(i).phone ?? ""}\nEmail : ${data.elementAt(i).email ?? ""}").tr(),

                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK').tr(),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: 30.0.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${data.elementAt(i).avatar}'))),
              child: const SizedBox.shrink(),
            ),
          ),
        ));
      }
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.0.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      taskName ?? "",
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ).tr(),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "assignee",
                style: TextStyle(
                    color: const Color(0xff8A8A8A),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ).tr(),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0 * assigns.length,
                    height: 40.0.h,
                    child: Stack(children: assigns),
                  ),
                  userCount == 0 ? const SizedBox():
                  Text(
                    '${userCount ?? 0}+',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: const Color(0xff8A8A8A),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ).tr(),
                  const Spacer(),
                  CustomTapBarButtonWithDate(
                    buttonColor: tapButtonColor,
                    firstDate: taskStartDate ?? "",
                    endData: taskEndDate ?? "",
                    verticalPadding: 6,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

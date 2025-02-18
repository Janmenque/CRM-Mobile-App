import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';

class CompleteListTaskCard extends StatelessWidget {
  const CompleteListTaskCard({
    Key? key,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.tapbuttonColor,
    this.taskName,
    this.completeTaskData,
    this.seeDetailsText,
    this.onTap,
  }) : super(key: key);

  final String? taskName, image1, image2, image3, image4, seeDetailsText;
  final Task? completeTaskData;

  final Color? tapbuttonColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> assigns = [];
    final data = completeTaskData?.members;
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
                  title: const Text("Data coming soon"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
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
        padding: EdgeInsets.symmetric(vertical: 2.h),
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
                  Text(
                    taskName ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                  Image.asset(
                    "assets/task/check.png",
                    height: 24.h,
                    width: 24.w,
                  )
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
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25.0 * assigns.length,
                          height: 40.0.h,
                          child: Stack(children: assigns),
                        ),
                        Text(
                          '${assigns.length}+',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: const Color(0xff8A8A8A),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  CustomTapBarButton(
                      buttonColor: const Color(0xffFFFFFF),
                      borderColor: const Color(0xff5B58FF),
                      textColor: const Color(0xff5B58FF),
                      fontSize: 14.sp,
                      buttonText: seeDetailsText ?? "",
                      verticalPadding: 5.h)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

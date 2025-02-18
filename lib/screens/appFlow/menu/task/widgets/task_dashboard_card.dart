import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/task/widgets/task_dash_board_card.dart';
import 'package:hrm_app/utils/res.dart';

class TaskDashboardCard extends StatelessWidget {
  const TaskDashboardCard(
      {Key? key, this.title, this.count, required this.customPainter, this.titileColor, this.titleAsset, this.ontap})
      : super(key: key);
  final String? title, count, titleAsset;
  final CustomPainter? customPainter;
  final Color? titileColor;
 final Function()? ontap;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.25,
          height: 185.h,
          child: Stack(
            children: [
              Positioned(
                  top: 14,
                  left: 5,
                  right: 0,
                  child: DashBoardCard(
                    image: titleAsset!,
                    title: title ?? "".tr(),
                    textColor: titileColor ?? AppColors.black,
                  )),
              CustomPaint(
                size: Size(
                    140,
                    (140 * 0.5555555555555556)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: customPainter,
              ),
              Positioned(
                  top: 13.h,
                  right: 0.w,
                  left: 53.w,
                  child: Text(
                    count ?? "0",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

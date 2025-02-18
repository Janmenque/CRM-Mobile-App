import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class DesignationSectionCart extends StatelessWidget {
  final String? title, status;
  final String? createdAt;
  final Function()? onTap;
  final Function()? onDeleteTap;
  const DesignationSectionCart(
      {Key? key, this.title, this.status, this.createdAt, this.onTap,this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/employee/departments_logo.png",
                height: 60.h,
              ),
              SizedBox(
                width: 22.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "$createdAt",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 28.0.h,
                      width: 121.0.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          status!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: InkWell(
                        onTap: onTap,
                        child: const PopupButtonDesign(
                          title: "edit",
                        )),
                  ),
                   PopupMenuItem(
                    value: 2,
                    child: InkWell(
                      onTap: onDeleteTap,
                        child: const PopupButtonDesign(
                      title: "delete",
                    )),
                  ),
                ],
                color: Colors.white,
                elevation: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopupButtonDesign extends StatelessWidget {
  final String? title;
  const PopupButtonDesign({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 6.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0XFF004D96),
                          Color(0XFF0082FF),
                        ])),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              Text(
                title!,
                style: TextStyle(color: Colors.grey[600]),
              )
            ]),
        const Divider()
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/support_new/support_dashboard/support_dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';

class SupportListScreen extends StatelessWidget {
  const SupportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Support Lists",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 11.5.h, horizontal: 13.5.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search a Support",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffCED1DA),
                          fontSize: 14.sp,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.sp),
                        height: 29.h,
                        width: 29.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff5B58FF)),
                        child: Image.asset(
                          "assets/task/search_bar.png",
                          height: 11.h,
                          width: 11.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            const  SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
              SizedBox(
                height: 02.h,
              ),
              SupportCard(
                overdueWidget: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: const Color(0xffFFECF0),
                      border: Border.all(color: const Color(0xffFED5DB))),
                  child: Text(
                    "Overdue by 3 days",
                    style: TextStyle(
                        color: const Color(0xffC82024),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
            const  SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
              SizedBox(
                height: 2.h,
              ),
            const  SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
              SizedBox(
                height: 02.h,
              ),
              SupportCard(
                overdueWidget: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: const Color(0xffFFECF0),
                      border: Border.all(color: const Color(0xffFED5DB))),
                  child: Text(
                    "Overdue by 3 days",
                    style: TextStyle(
                        color: const Color(0xffC82024),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
            const  SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
              SizedBox(
                height: 2.h,
              ),
             const SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
              SizedBox(
                height: 02.h,
              ),
              SupportCard(
                overdueWidget: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: const Color(0xffFFECF0),
                      border: Border.all(color: const Color(0xffFED5DB))),
                  child: Text(
                    "Overdue by 3 days",
                    style: TextStyle(
                        color: const Color(0xffC82024),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
             const SupportCard(
                clientAlart: "Customer responded 1h ago",
                titile: "THW - New email template creation",
                code: "6493",
                note: "Darren Adams",
                category: "Headboard Workshop",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

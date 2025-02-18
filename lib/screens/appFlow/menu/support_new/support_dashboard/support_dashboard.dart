import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/support_new/support_list_screen/support_list_sceen.dart';
import 'package:hrm_app/screens/custom_widgets/dashboard.dart';
import 'package:hrm_app/screens/custom_widgets/see_all_title.dart';
import 'package:hrm_app/utils/res.dart';

class SupportDashboardScreen extends StatelessWidget {
  const SupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        title: Text("Support", style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 17.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DashboardCardCashImage(
                    backgroundInage: "assets/support/support_open.png",
                    title: "Open",
                    amount: "6",
                    amounttop: 35.0.h,
                    amountright: 15.0.w,
                    titileTop: 58.0.h,
                    titleRight: 20.0.w,
                  ),
                  
                  DashboardCardCashImage(
                    backgroundInage: "assets/support/support_in_progress.png",
                    title: "In Progress",
                    amount: "12",
                    amounttop: 35.0.h,
                    amountright: 20.0.w,
                    titileTop: 58.0.h,
                    titleRight: 15.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DashboardCardCashImage(
                    backgroundInage: "assets/support/support_answered.png",
                    title: "Answered",
                    amount: "6",
                    amounttop: 35.0.h,
                    amountright: 15.0.w,
                    titileTop: 58.0.h,
                    titleRight: 20.0.w,
                  ),
                  DashboardCardCashImage(
                    backgroundInage: "assets/support/support_close.png",
                    title: "Closed",
                    amount: "12",
                    amounttop: 35.0.h,
                    amountright: 20.0.w,
                    titileTop: 58.0.h,
                    titleRight: 15.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
               SeeAllTitle(
                        titile: "Clients",
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const SupportListScreen()),
                          );
                        },
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
            const  SupportCard(
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
                height: 30.h,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  const SupportCard(
      {Key? key,
      this.overdueWidget,
      this.clientAlart,
      this.titile,
      this.code,
      this.category,
      this.note})
      : super(key: key);
  final Widget? overdueWidget;
  final String? clientAlart, titile, code, note, category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 19.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 13.h,
                  width: 13.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      border: Border.all(
                          color: const Color(0xff9AA3AB), width: 1.5)),
                ),
                SizedBox(
                  width: 13.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            overdueWidget ?? const SizedBox(),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 5.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  color: const Color(0xffCCDAF9),
                                  border:
                                      Border.all(color: const Color(0xffB3C9DD))),
                              child: Text(
                                clientAlart ?? "",
                                style: TextStyle(
                                    color: const Color(0xff2C5EC6),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          code ?? "",
                          style: TextStyle(
                              color: const Color(0xff5B58FF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 4.h,),
                    Text(
                      titile ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 4.h,),
                    Row(
                      children: [
                        Image.asset(
                          "assets/support/support_message.png",
                          height: 11.h,
                          width: 11.w,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          note ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff9AA3AB), fontSize: 10.sp),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 4.h,
                          width: 4.w,
                          decoration: const BoxDecoration(
                              color: Color(0xff9AA3AB), shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          category ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff9AA3AB), fontSize: 10.sp),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

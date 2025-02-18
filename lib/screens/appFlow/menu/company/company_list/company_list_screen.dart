import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/company/content/company_list_card.dart';

class CompanyListScreen extends StatelessWidget {
  const CompanyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(

        elevation: 0,
        title:  Text("Company List", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEBEBEB)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextFormField(
                        maxLines: 1,
                        cursorColor: const Color(0xff5B58FF),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical :8.0),
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                height: 29.h,
                                width: 29.w,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff5B58FF)),
                                child: Image.asset(
                                  "assets/task/search_bar.png",
                                  height: 11.h,
                                  width: 11.w,
                                ),
                              ),
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
              SizedBox(height: 10.h,),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
              CompanyListCard(
                ontap: () { },
                name: "Onest Tech",
                email: "Onesttech@gmail.com",
                companyLogo: "assets/stocks/upwork.png",
                number: "01254687889",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

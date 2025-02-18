import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyListCard extends StatelessWidget {
  const CompanyListCard(
      {Key? key,
        this.email,
        this.name,
        this.number,
        required this.companyLogo,
        this.ontap})
      : super(key: key);

  final String? email, name, companyLogo, number;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 Image.asset(companyLogo!, height: 60, width: 60,),
                  SizedBox(
                    width: 22.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Image.asset(
                            "assets/clients/client_check.png",
                            height: 12.h,
                            width: 12.w,
                          )
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/clients/phone.png",
                            height: 13.h,
                            width: 13.w,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            number ?? "",
                            style: TextStyle(
                                color: const Color(0xffBABABA),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/clients/client_email.png",
                            height: 20.h,
                            width: 15.w,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            email ?? "",
                            style: TextStyle(
                                color: const Color(0xffBABABA),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

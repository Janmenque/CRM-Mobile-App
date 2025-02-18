import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/add_employee/add_employee_screen.dart';

class AddAndSearchWidget extends StatelessWidget {
  const AddAndSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 11.5.h, horizontal: 13.5.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/Group.png",
                  height: 17.24.h,
                  width: 17.24.w,
                ),
                SizedBox(
                  width: 9.24.w,
                ),
                Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff4A43EC),
                    fontSize: 14.sp,
                  ),
                )
              ],
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
                    builder: (context) => const AddEmployeeScreen()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
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
    );
  }
}

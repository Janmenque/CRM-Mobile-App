import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/label_text.dart';
import 'package:hrm_app/utils/res.dart';

class AddBrandForm extends StatelessWidget {
  const AddBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Add Brand",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 26.0, top: 20),
              child: Text(
                "SAVE",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Brand Information",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LavelText(
                      text: "Brand Name",
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  const  AddClientTextField(
                      hintText: "Brand Name",
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Text(
                          "Image",
                          style: TextStyle(
                              color: AppColors.black2,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/stocks/image_add.png',
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "ADD IMAGE",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5B58FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/screens/custom_widgets/horizontal_divider.dart';
import 'package:hrm_app/screens/custom_widgets/label_text.dart';
import 'package:hrm_app/utils/res.dart';
import '../../../../custom_widgets/add_client_textfield.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Add Product",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.w),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Information",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const LavelText(
                  text: "Product Name",
                ),
                const SizedBox(
                  height: 4,
                ),
               const AddClientTextField(
                  hintText: "Product Name",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Category",
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Smart Phone",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.lightGrey,
                      size: 12.sp,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Description",
                ),
                const SizedBox(
                  height: 4,
                ),
              const  AddClientTextField(
                  hintText: "Add Description",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Brand",
                ),
                const SizedBox(
                  height: 4,
                ),
              const  AddClientTextField(
                  hintText: "Add Brand",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Brand",
                ),
                const SizedBox(
                  height: 4,
                ),
             const   AddClientTextField(
                  hintText: "Setect a Brand",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Video URL",
                ),
                const SizedBox(
                  height: 4,
                ),
              const  AddClientTextField(
                  hintText: "Add Video URL",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Screen Size (Inches)",
                ),
                const SizedBox(
                  height: 4,
                ),
                const AddClientTextField(
                  hintText: "Add Screen Size",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Short Description",
                ),
                const SizedBox(
                  height: 4,
                ),
               const  AddClientTextField(
                  hintText: "Add Description",
                ),
                const SizedBox(
                  height: 14,
                ),
                const LavelText(
                  text: "Color Family",
                ),
                const SizedBox(
                  height: 2,
                ),
                const LavelText(
                  text: "Black, Blue green",
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Black",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/stocks/add_image.png",
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Add Image",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffEAEAEA)),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Stock"),
                          SizedBox(
                            height: 04.h,
                          ),
                        const  AddClientTextField(
                            hintText: "02",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Price"),
                          SizedBox(
                            height: 04.h,
                          ),
                         const AddClientTextField(
                            hintText: "22.00",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Greem",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/stocks/add_image.png",
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Add Image",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
               const HorizontalDivider(dividerColor:  Color(0xffEAEAEA)),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Stock"),
                          SizedBox(
                            height: 04.h,
                          ),
                         const AddClientTextField(
                            hintText: "02",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Price"),
                          SizedBox(
                            height: 04.h,
                          ),
                         const AddClientTextField(
                            hintText: "22.00",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blue",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/stocks/add_image.png",
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Add Image",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
              const  HorizontalDivider(dividerColor:  Color(0xffEAEAEA)),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Stock"),
                          SizedBox(
                            height: 04.h,
                          ),
                       const   AddClientTextField(
                            hintText: "02",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LavelText(text: "Price"),
                          SizedBox(
                            height: 04.h,
                          ),
                         const AddClientTextField(
                            hintText: "22.00",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B58FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';

class CreateInvoice extends StatelessWidget {
  const CreateInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Create Invoice",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SizedBox(
                        width: 120.w,
                        height: 35.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(
                              color: const Color(0xff8A8A8A),
                              fontSize: 14.sp,
                            ),
                            cursorColor: const Color(0xff5B58FF),
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "No-"),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/stocks/logo_form.png',
                    height: 100.h,
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "From",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12.h,
              ),
            const  AddClientTextField(
                hintText: "Business Name",
              ),
              SizedBox(
                height: 12.h,
              ),
             const AddClientTextField(
                hintText: "Email",
              ),
              SizedBox(
                height: 12.h,
              ),
             const AddClientTextField(
                hintText: "Phone",
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Bill To",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12.h,
              ),
             const AddClientTextField(
                hintText: "Clinet name",
              ),
              SizedBox(
                height: 12.h,
              ),
             const AddClientTextField(
                hintText: "Email",
              ),
              SizedBox(
                height: 12.h,
              ),
            const  AddClientTextField(
                hintText: "Phone",
              ),
              SizedBox(
                height: 30.h,
              ),
            const  AddClientTextField(
                hintText: "Item Description",
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                const  Expanded(
                    child: AddClientTextField(
                      hintText: "Price",
                    ),
                  ),
                  const Icon(Icons.close),
                const  Expanded(
                    child: AddClientTextField(
                      hintText: "Qty",
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "\$0.00",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "Item",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.black),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: AppColors.black,
                            size: 24.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "Item",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Subtotal:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Text(
                    "\$00.00",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5B58FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: Text(
                  "Save Invoice",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

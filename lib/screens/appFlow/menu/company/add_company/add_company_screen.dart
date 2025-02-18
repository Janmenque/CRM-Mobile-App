import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';
import '../../../../custom_widgets/add_client_textfield.dart';
import '../../../../custom_widgets/label_text.dart';

class AddCompanyScreen extends StatelessWidget {
  const AddCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Company",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: InkWell(
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFFE4E4E4),
                                        width: 8)),
                                child: const Icon(
                                Icons.photo,
                                  color: Colors.grey,
                                  size: 60,
                                )
                              ),
                             Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorPrimary),
                                  child: const Icon(
                                    size: 18.0,
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const LavelText(
                      text: "Company's Name * ",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                   const AddClientTextField(
                        hintText: "Enter Company's Name",
                    ),
                     SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "User Name * ",

                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter User name",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "Company's Email * ",

                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter Company's Email",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "Company's Phone Number * ",

                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter Company's Phone Number",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "Company's Total Employee * ",

                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter Company's Total Employee",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "Business Type * ",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter Business Type",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LavelText(
                      text: "Trade Licence Number * ",

                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AddClientTextField(
                      hintText: "Enter Trade Licence Number",
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal : 16.w, vertical: 16.h),
            child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5B58FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  minimumSize: Size(double.infinity, 60.h),
                ),
                child: Text(
                  "Add Company",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}

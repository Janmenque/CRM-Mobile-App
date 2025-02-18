import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/server/respository/employee_repository/employee_repository.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/utils/res.dart';

class AddDesignation extends StatefulWidget {
  const AddDesignation({super.key});

  @override
  State<AddDesignation> createState() => _AddDesignationState();
}

class _AddDesignationState extends State<AddDesignation> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        appBar:AppBar(
                    elevation: 0,
            title:  Text("add_designation".tr(), style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
            ),
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 70.h,
          ),
          Text(
            "Designation name*",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ).tr(),
          SizedBox(
            height: 10.h,
          ),
          Form(
            key: formKey,
            child: AddClientTextField(
              textController: textController,
              hintText: "Designation name".tr(),
            ),
          ),
          SizedBox(
            height: 117.h,
          ),
          SizedBox(
            height: 50.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await sendDesignationData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5B58FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                "save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
        ]),
      ),
    );
  }

  sendDesignationData() async {
    final data = {'title': textController.text};
    final response = await EmployeeRepository.addDesignation(data);
    if (response['result'] == true) {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}

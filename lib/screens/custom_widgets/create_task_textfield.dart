import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTaskTextField extends StatelessWidget {
 const CreateTaskTextField({super.key, this.hintText, this.maxLine, this.textController});
  final String? hintText;
 final int? maxLine;
    final TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return Container(
    
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEBEBEB)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)),
      child: TextField(
        maxLines: maxLine ?? 1,
         controller: textController,
        cursorColor: const Color(0xff5B58FF),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: const Color(0xff8A8A8A),
                fontWeight: FontWeight.bold,
                fontSize: 12.sp),
            hintText: hintText ?? "Enter your value"),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddClientTextField extends StatelessWidget {
  const AddClientTextField(
      {Key? key, this.hintText, this.maxLine, this.textController})
      : super(key: key);
  final String?  hintText;
  final TextEditingController? textController;
 final  int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEAEAEA)),
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
        
        controller: textController,
        maxLines: maxLine ?? 1,
        cursorColor: const Color(0xff5B58FF),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Enter_your_value".tr()),
        validator: (value) {
          if (value!.isEmpty) {
            return tr("this_field_is_required");
          }
          return null;
        },
      ),
    );
  
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCreateAndSearchContent extends StatelessWidget {
   const ProductCreateAndSearchContent({
    super.key, this.onTap, this.title
  });
   final Function()? onTap;
   final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.5.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r)),
            child: TextFormField(
              onChanged: ((value) {}),
              maxLines: 1,
              cursorColor: const Color(0xff5B58FF),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xffCED1DA),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp),
                  hintText: title ?? "Search"),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
            decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
            child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
          ),
        )
      ],
    );
  }
}
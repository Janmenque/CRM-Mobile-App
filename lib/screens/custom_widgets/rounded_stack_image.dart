import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedStackImages extends StatelessWidget {
  const RoundedStackImages(
      {Key? key,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      
      })
      : super(key: key);
  final String? image1, image2, image3, image4;
  @override
  Widget build(BuildContext context) {
    return SizedBox(   
      width: 90,
      height: 39,
      child: Stack(children: [
        Image.asset(
          image1!,
          height: 36.h,
          width: 36.w,
        ),
        Positioned(
            left: 22.w,
            child: Image.asset(
              image2!,
              height: 36.h,
              width: 36.w,
            )),
        Positioned(
            left: 45.w,
            child: Image.asset(
              image3!,
              height: 36.h,
              width: 36.w,
            )),
              Positioned(
            left: 67.w,
            child: Image.asset(
              image4!,
              height: 36.h,
              width: 36.w,
            ))
      ]),
    );
  
  }
}
  
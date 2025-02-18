
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeListUpdateCard extends StatelessWidget {
  const EmployeeListUpdateCard(
      {Key? key,
      this.image,
      this.name,
      this.designation,
      this.address,
      this.onTap})
      : super(key: key);

  final String? image, name, designation, address;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 CachedNetworkImage(
                  imageUrl:  image ?? "",
                     placeholder: (_,__){
                      return  const Icon(CupertinoIcons.person_solid, color: Colors.grey, size: 60,);},
                    errorWidget: (_,__,___){
                      return  const Icon(CupertinoIcons.person_solid, color: Colors.grey, size: 60,);
                    },
                    height: 60.h,
                    width: 60.w,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.3.h),
                      ),
                      Text(
                        designation ?? "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.3.h),
                      ),
                      Text(
                        address ?? "",
                        style: TextStyle(
                            color: const Color(0xff8A8A8A),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.3.h),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

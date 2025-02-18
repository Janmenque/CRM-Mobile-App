
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';


class UpdatedMenuDashboardCard extends StatelessWidget {
   UpdatedMenuDashboardCard({
    super.key, this.image, this.onPressed, this.title, this.imageType, this.label, this.index
  });
  int? index;
  String? image;
  String? title;
  String? imageType;
  String? label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CachedNetworkImage(
                  //fit: BoxFit.cover,
                  imageUrl: image ?? "https://www.w3schools.com/howto/img_avatar.png", color: AppColors.colorPrimary,
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/placeholder_image.png", height: 20.h,width: 20.w,),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),),
            const SizedBox(height: 10),
            Text( title ?? "", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
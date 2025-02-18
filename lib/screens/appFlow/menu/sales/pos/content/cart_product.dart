import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';

class MyCardProductWidget extends StatelessWidget {
  const MyCardProductWidget({
    super.key, this.image, this.title, this.price, this.quantity, this.incrementTap, this.decrementTap, this.variantId, this.currency
  });

  final String? image, title, quantity ;
  final double? price;
  final int? variantId;
  final Function()? incrementTap;
  final String? currency;
  final Function()? decrementTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 80.h,
                width: 100,
                fit: BoxFit.fill,
                imageUrl: image ?? "",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/app_logo.png"),),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
            const Spacer(flex: 1,),
            Expanded(
              flex: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "", style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2.h,),
                  Text( "\$ ${price?.toStringAsFixed(2) ?? ""}", style: TextStyle(color: AppColors.colorPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 4.h,),
                  Row(
                    children: [
                      InkWell(
                        onTap: decrementTap,
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Icon(Icons.remove, color: AppColors.colorPrimary, size: 12.sp,)),
                      ),
                      SizedBox(width: 12.w,),
                      Text(quantity ?? "", style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500),),
                      SizedBox(width: 12.w,),
                      InkWell(
                        onTap: incrementTap,
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.2),),
                            child: Icon(Icons.add, color: AppColors.colorPrimary,size: 12.sp,)),
                      ),
                      SizedBox(width: 12.w,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12,),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.2),
        ),
        const SizedBox(height: 12,),
      ],
    );
  }
}
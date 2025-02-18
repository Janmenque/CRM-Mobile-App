import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import '../../../../../custom_widgets/horizontal_divider.dart';

class ClientProfileDetailsCard extends StatelessWidget {
  const ClientProfileDetailsCard({Key? key, this.client}) : super(key: key);

  final Client? client;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xff5B58FF),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: client?.avater ?? '',
                  fit: BoxFit.cover,
                  placeholder: (_, __) {
                    return const Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.grey,
                      size: 60,
                    );
                  },
                  errorWidget: (_, __, ___) {
                    return const Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.grey,
                      size: 60,
                    );
                  },
                  height: 120.h,
                  width: 120.w,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Center(
                child: Text(
              client?.name ?? "",
              //"Bessie Cooper",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            )),
            SizedBox(
              height: 8.h,
            ),
            Text(
              client?.description ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xffD9D9D9),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ).tr(),
            SizedBox(
              height: 22.h,
            ),
            const HorizontalDivider(
              dividerColor: Color(0xffDFDFDF),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        client?.projectStatistics?.first.count.toString() ??
                            "00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        client?.projectStatistics?.first.title ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ).tr()
                    ],
                  ),
                ),
                Container(
                  height: 44.h,
                  color: const Color(0xffDFDFDF),
                  width: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      client?.projectStatistics?[1].count.toString() ?? "00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      client?.projectStatistics?[1].title ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            const HorizontalDivider(
              dividerColor: Color(0xffDFDFDF),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        client?.projectStatistics?[2].count.toString() ?? "00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        client?.projectStatistics?[2].title ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 44.h,
                  color: const Color(0xffDFDFDF),
                  width: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      client?.projectStatistics?[3].count.toString() ?? "00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      client?.projectStatistics?[3].title ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            const HorizontalDivider(
              dividerColor: Color(0xffDFDFDF),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "phone",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3.h),
            ).tr(),
            Text(
              client?.phone ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3.h),
            ),
            SizedBox(height: 16.h),
            Text(
              "email",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3.h),
            ).tr(),
            Text(
              client?.email ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3.h),
            ),
            SizedBox(height: 16.h),
            Text(
              "location",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3.h),
            ).tr(),
            Text(
              client?.address ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3.h),
            ),
            SizedBox(height: 16.h)
          ],
        ),
      ),
    );
  }
}

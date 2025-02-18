import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import '../../projects/project_details/project_details_screen.dart';

class ClientDealsCard extends StatelessWidget {
  const ClientDealsCard({Key? key, this.project}) : super(key: key);

  final Project? project;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    project?.avatar ?? '',
                    height: 34.h,
                    width: 34.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project?.name ?? "no_name_available",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          )).tr(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 6.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: project?.getColor,
                            ),
                          ),
                          SizedBox(
                            width: 3.5.w,
                          ),
                          Text(
                            project?.status ?? "activity_on_pending",
                            style: TextStyle(
                              color: project?.getColor,
                              fontSize: 14.sp,
                            ),
                          ).tr(),
                          SizedBox(
                            width: 3.5.w,
                          ),
                          Text(
                            project?.date ?? "",
                            style: TextStyle(
                              color: const Color(0xffBDBDBD),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              NavUtil.navigateScreen(
                  context,
                  ProjectDetailsScreen(
                    project: project,
                    projectId: project?.id,
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.5.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(06.r),
                  border: Border.all(color: const Color(0xff7F58FE))),
              child: Text(
                "view_details",
                style: TextStyle(
                    color: const Color(0xff7F58FE),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
          )
        ],
      ),
    );
  }
}

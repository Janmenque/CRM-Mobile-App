
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/my_visit/my_visit_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class MyVisitScreen extends StatelessWidget {
  const MyVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyVisitProvider(),
      child: Consumer<MyVisitProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              provider.isLoading
                  ? provider.visitList!.data!.myVisits!.isNotEmpty
                      ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                provider.visitList?.data?.myVisits?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [

                                  InkWell(
                                    onTap: () {
                                      NavUtil.navigateScreen(
                                          context,
                                          VisitDetails(
                                              visitID: provider.visitList?.data
                                                  ?.myVisits?[index].id));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0, vertical: 5),
                                      child: Container(
                                        decoration : BoxDecoration(
                                          color: Colors.white,
                                              borderRadius: BorderRadius.circular(10.r)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .visitList
                                                          ?.data
                                                          ?.myVisits?[index]
                                                          .title ??
                                                          "",
                                                      style:  TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          provider
                                                              .visitList
                                                              ?.data
                                                              ?.myVisits?[index]
                                                              .date ??
                                                              "",
                                                          style:  TextStyle(
                                                              fontSize: 12.sp, color: const Color(0xff555555), fontWeight: FontWeight.bold),
                                                        ),
                                                         SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(

                                                            color: AppColors.primaryColor,

                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                          ),
                                                          child: Padding(
                                                            padding:  EdgeInsets.symmetric( vertical : 4.h, horizontal : 10.w),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  provider
                                                                      .visitList
                                                                      ?.data
                                                                      ?.myVisits?[
                                                                  index]
                                                                      .status ??
                                                                      "",
                                                                  style:  TextStyle(
                                                                      color:
                                                                      Colors.white,
                                                                      fontSize: 10.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ).tr(),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Image.asset("assets/images/clock.png", height: 15.sp, width: 15.w, )
                                                              ],
                                                            ),
                                                          ),
                                                      
                                                      
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color:
                                                AppColors.primaryColor,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );

                            }),
                      )
                      : 
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            Image.asset("assets/images/no_visit_image.png",  width: 158.w, height: 142.h,),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text("No field visit scheduled yet", style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, ),),
                             Text("Schedule meetings and\neasily record all the events of\nthe visit.", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xff555555), fontSize: 14.sp, ),)
                          ],
                        ),
                      )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}

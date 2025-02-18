import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/reschedul_visit/reschedule_visit.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/update_visit/update_visit.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_cancel/visit_cancel_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details_google_map.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_note/visit_note.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class VisitDetails extends StatelessWidget {
  final int? visitID;

  const VisitDetails({Key? key, this.visitID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VisitDetailsProvider(visitID),
      child: Consumer<VisitDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: const Color(0xffF5F6FA),
   
            appBar: AppBar(
              elevation: 0,
                 leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
              backgroundColor: AppColors.white,
              title:  Text(
                tr("visit_details"),
                  style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    NavUtil.replaceScreen(
                        context,
                        UpdateVisitScreen(
                          responseVisitList: provider.visitDetails,
                          visitID: visitID,
                        ));
                  },
                  child:Padding(
                    padding:  EdgeInsets.only(right: 15.w),
                    child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                  ),
                ),
              ],
            ),
            
            body: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(provider.visitDetails?.data?.date?.toString() ??
                            ""),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(int.parse(
                                  provider.visitDetails?.data?.statusColor ??
                                      "0xFF000000")),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(
                                provider.visitDetails?.data?.statusColor ??
                                    "0xFF000000")),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            strokeWidth: 1,
                            child: Text(
                              provider.visitDetails?.data?.status ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ).tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      provider.visitDetails?.data?.title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      provider.visitDetails?.data?.description ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    child: Text(
                      tr("location"),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: VisitDetailsGoogleMap(),
                          )),
                    ),
                  ),
                   Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                    child: Text(
                      tr("phone_optional"),
                      style:
                          const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SizedBox(
                      height: 60.0,
                      child: InkWell(
                        onTap: () {
                          provider.pickImage(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: DottedBorder(
                                  color: Colors.blue,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  strokeWidth: 1,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  )),
                            ),
                            Expanded(
                              flex: 4,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: provider.imageListSever?.length ?? 0,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      imageUrl: provider
                                              .imageListSever?[index] ??
                                          "https://www.w3schools.com/howto/img_avatar.png",
                                      placeholder: (context, url) => Center(
                                        child: Image.asset(
                                            "assets/images/placeholder_image.png"),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        provider.visitDetails?.data?.schedules?.length ?? 0,
                    itemBuilder: (context, index) {

                      return InkWell(
                        onTap: () {
                          provider.goToPosition(LatLng(
                              double.parse(provider.visitDetails?.data
                                      ?.schedules?[index].latitude ??
                                  ""),
                              double.parse(provider.visitDetails?.data
                                      ?.schedules?[index].longitude ??
                                  "")));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.visitDetails?.data?.schedules?[index]
                                        .title ??
                                    "",
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              provider.locationListServer.isNotEmpty && provider.locationListServer.length > index
                                  ? Text(provider.locationListServer[index] ?? tr("loading"))
                                  :  Text(tr("loading")),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                provider.visitDetails?.data?.schedules?[index]
                                        .dateTime ??
                                    "",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                           tr("Photo_optional"),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: DottedBorder(
                                    color: Colors.blue,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    strokeWidth: 1,
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                    )),
                              ),
                              const Icon(
                                Icons.phone_android_outlined,
                                size: 45,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: provider.visitDetails?.data?.nextStatus
                                ?.statusText?.isEmpty ==
                            false,
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Text(
                            tr("visit_notes"),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            provider.visitDetails?.data?.notes?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.visitDetails?.data?.notes?[index]
                                          .note ??
                                      "",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black45),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                      Visibility(
                        visible: provider.visitDetails?.data?.nextStatus
                                ?.statusText?.isEmpty ==
                            false,
                        child: InkWell(
                          onTap: () {
                            NavUtil.replaceScreen(
                                context,
                                VisitNote(
                                    visitId: provider.visitDetails?.data?.id));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10),
                                child: Row(
                                  children:  [
                                    Text(
                                      tr("visit_notes"),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.add)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: provider.isUpdateBottomShow,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                NavUtil.replaceScreen(
                                    context,
                                    RescheduleVisit(
                                      visitId: provider.visitDetails?.data?.id,
                                    ));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              child: const Text('reschedule',
                                  style: TextStyle(
                                    color: AppColors.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  )).tr(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                NavUtil.replaceScreen(
                                    context,
                                    VisitCancelScreen(
                                      visitId: provider.visitDetails?.data?.id,
                                    ));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              child: const Text('cancel',
                                  style: TextStyle(
                                    color: AppColors.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  )).tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: provider.visitDetails?.data?.nextStatus?.statusText
                            ?.isEmpty ==
                        false,
                    child: CustomButton(
                      title:
                          provider.visitDetails?.data?.nextStatus?.statusText ??
                              "",
                      clickButton: () {
                        provider.changeStatusVisitApi();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

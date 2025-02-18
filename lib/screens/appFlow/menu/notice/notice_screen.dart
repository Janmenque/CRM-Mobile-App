import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/create_notice_report/create_notice_report.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_details_screen/notice_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoticeProvider(),
      child: Consumer<NoticeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            floatingActionButton: Visibility(
              visible: provider.hrOrAdmin ?? false,
              // visible: true,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  NavUtil.replaceScreen(context, const CreateNoticeReport());
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                tr('notice'),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16.sp),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  ///current date picker
                  currentDate(provider, context),

                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        provider.clearNoticeApi();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            Text(
                              tr("clear_all_notice"),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Notice List
                  provider.isLoading
                      ? provider.responseNoticeList!.data!.notices!.data!
                              .isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: provider.responseNoticeList?.data
                                          ?.notices?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final data = provider.responseNoticeList
                                        ?.data?.notices?.data?[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Card(
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 8),
                                          child: ListTile(
                                            onTap: () => NavUtil.navigateScreen(
                                              context,
                                              NoticeDetailsScreen(
                                                  noticeId: data!.id),
                                            ),
                                            title: Text(
                                              data?.subject ?? '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            subtitle: Text(
                                              data?.date ?? '',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            leading: ClipOval(
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                imageUrl: provider
                                                        .responseNoticeList
                                                        ?.data
                                                        ?.notices
                                                        ?.data?[index]
                                                        .file ??
                                                    "assets/images/placeholder_image.png",
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Image.asset(
                                                      "assets/images/placeholder_image.png"),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/placeholder_image.png"),
                                              ),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.colorPrimary,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          :  Expanded(
                              child: Center(
                                  child: Text(
                                tr("no_notice_found"),
                                style: const TextStyle(
                                    color: Color(0x65555555),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              )),
                            )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell currentDate(NoticeProvider provider, BuildContext context) {
    return InkWell(
      onTap: () {
        provider.selectDate(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical : 10.0, horizontal: 14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
                borderRadius: BorderRadius.circular(10),

          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.selectDate(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 30,
                    color: AppColors.colorPrimary,
                  )),
              const Spacer(),
              Center(
                  child: Text(
                provider.monthYear ?? "",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    provider.selectDate(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: 30,
                    color: AppColors.colorPrimary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

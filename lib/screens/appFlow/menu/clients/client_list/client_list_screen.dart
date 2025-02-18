import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/provider/client_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/widgets/client_list_card.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/screen/new_client_details_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmClientProvider(context),
        child: Consumer<CrmClientProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Clinet List".tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffEBEBEB)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: TextFormField(
                              onChanged: ((value) {
                                provider.getSearchValue(value);
                              }),
                              maxLines: 1,
                              cursorColor: const Color(0xff5B58FF),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      height: 29.h,
                                      width: 29.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff5B58FF)),
                                      child: Image.asset(
                                        "assets/task/search_bar.png",
                                        height: 11.h,
                                        width: 11.w,
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xffCED1DA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                  hintText: "Search".tr()),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    provider.crmClientListREsponse?.data?.clients != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider
                                .crmClientListREsponse?.data?.clients?.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = provider
                                  .crmClientListREsponse?.data?.clients?[index];
                              return ClientListCard(
                                ontap: () {
                                  if (kDebugMode) {
                                    print("chekc client list card");
                                  }
                                  NavUtil.navigateScreen(
                                      context,
                                      NewClientDetailsScreen(
                                        clientId: data!.id!,
                                      ));
                                },
                                name: data?.name,
                                email: data?.email,
                                profileImage: data?.avater,
                                number: data?.phone,
                              );
                            })
                        : const CustomListShimer()
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_deal_list/client_deal_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_details/client_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/edit_client/edit_client_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/widgets/client_deal_card.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../../utils/res.dart';
import 'contents/client_profile_details_card.dart';

class ClientDetailsScreen extends StatelessWidget {
  final int clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
        child: ChangeNotifierProvider(
      create: ((context) => CrmClientDetailsProvider(clientId)),
      child:
          Consumer<CrmClientDetailsProvider>(builder: (context, provider, _) {
        final data = provider.crmClientDetailsResponse?.data?.client;
        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),
          appBar: AppBar(
            elevation: 0,
            actions: [
              Visibility(
                visible: provider.isAdmin ?? false,
                child: InkWell(
                  onTap: () {
                    NavUtil.navigateScreen(
                        context,
                        EditClientScreen(
                          clientDetails: provider.crmClientDetailsResponse,
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.colorPrimary),
                    child: Icon(
                      size: 14.0.r,
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: provider.isAdmin ?? false,
                child: InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print(clientId);
                    }
                    provider.crmClientDelete(clientId, context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.colorPrimary),
                    child: Icon(
                      size: 14.0.r,
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              )

            ],
            title: Text(
              "client_details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ).tr(),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 21.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClientProfileDetailsCard(client: data),
                  SizedBox(
                    height: 24.h,
                  ),
                  if (data != null)
                    data.projects!.isNotEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Deals",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    )).tr(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ClientDealListScreen(
                                                  clientId: data.id ?? 0)),
                                    );
                                  },
                                  child: Text("see_all",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      )).tr(),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Deals",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      )).tr(),
                                  Text("see_all",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      )).tr(),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text("project_hadn't_added_yet").tr()
                            ],
                          ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data?.projects?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final projectData = data?.projects?[index];
                        return ClientDealsCard(
                          project: projectData,
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}

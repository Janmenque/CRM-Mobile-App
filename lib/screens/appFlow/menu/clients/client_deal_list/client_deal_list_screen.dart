import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_deal_list/client_deal_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/widgets/client_deal_card.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:provider/provider.dart';

class ClientDealListScreen extends StatelessWidget {
  const ClientDealListScreen({super.key, required this.clientId});
  final int clientId;

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
        child: ChangeNotifierProvider(
      create: ((context) => ClientDealListProvider(clientId)),
      child: Consumer<ClientDealListProvider>(builder: (context, provider, _) {
        final data = provider.dealListResponse?.data?.projects;
        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Deal List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEBEBEB)),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                hintText: "Search...."),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

                 data != null ?  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final projectData = data[index];
                        Project project = Project(
                            id: projectData.id,
                            name: projectData.title,
                            status: projectData.status,
                            avatar: projectData.avatar,
                            date: projectData.date);
                        return ClientDealsCard(
                          project: project,
                        );
                      }) : const CustomListShimer()
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}

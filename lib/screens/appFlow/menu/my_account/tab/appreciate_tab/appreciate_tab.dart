import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/appreciate_tab/appreciate_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AppreciateTab extends StatelessWidget {
  const AppreciateTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppreciateProvider(),
      child: Consumer<AppreciateProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              body: Column(
            children: [
              provider.isLoading == true ? provider.appreciateList!.data!.appreciates!.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: provider.appreciateList?.data?.appreciates?.length ?? 0,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                provider.appreciateList?.data?.appreciates?[index].date ?? "",
                                                maxLines: 1,
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0.5)),
                                            Text(
                                                provider.appreciateList?.data?.appreciates?[index].day ?? "",
                                                style: const TextStyle(fontSize: 12, color: Color(0xFF555555), fontWeight: FontWeight.w400, height: 1.4, letterSpacing: 0.5)),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                                        child: VerticalDivider(
                                          color: AppColors.colorPrimary,
                                          thickness: 2,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.appreciateList?.data?.appreciates?[index].appreciateBy ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 14, color: Color(0xFF222222), fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0.5),
                                            ),
                                            Text(
                                              provider.appreciateList?.data?.appreciates?[index].message ?? "",
                                              style: const TextStyle(fontSize: 14, color: Color(0xFF555555), fontWeight: FontWeight.w400, height: 1.4, letterSpacing: 0.5),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(thickness: 1);
                            },
                          ),
                        )
                      :  Expanded(
                          child: Center(
                              child: Text(tr("You_are_not_appreciated_yet"),
                            style: const TextStyle(color: Color(0x65555555), fontSize: 22, fontWeight: FontWeight.w500),)),
                        )
                  : const SizedBox()
            ],
          ));
        },
      ),
    );
  }
}

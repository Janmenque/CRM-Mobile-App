import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/create_visit/create_visit_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/my_visit/my_visit_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'history/history_screen/history_screen.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({Key? key}) : super(key: key);

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VisitProvider(),
      child: Consumer<VisitProvider>(
        builder: (context, provider, _) {
          return Scaffold(
             backgroundColor: AppColors.backgroundColor,
            appBar: 
       PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child:  CustomTitleAppBar(
          title: "my_visit".tr(), 
        ),
      ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                NavUtil.replaceScreen(context, const CreateVisitScreen());
              },
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade400),
                      )),
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.black,
                      labelColor: AppColors.primaryColor,
                      indicatorColor: AppColors.primaryColor,
                      automaticIndicatorColorAdjustment: true,
                      controller: _tabController,
                      labelStyle: const TextStyle(fontFamily: 'cairo'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs:  [
                        Tab(
                          child: Text(tr("my_visit", ), style:  TextStyle(fontWeight: FontWeight.bold, fontSize:16.sp),),
                        ),
                        
                        Tab(
                           child: Text(tr("history", ), style:  TextStyle(fontWeight: FontWeight.bold, fontSize:16.sp),),
                        )
                      ]),
                ),
                Expanded(
                  child:
                      TabBarView(controller: _tabController, children: const [
                    MyVisitScreen(),
                    HistoryScreen()
                  ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

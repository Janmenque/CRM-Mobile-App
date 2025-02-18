import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/componets/menu_drawer.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/view/product_list.dart';
import 'package:hrm_app/screens/appFlow/menu/updated_menu_card.dart';
import 'package:hrm_app/screens/appFlow/natification/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/res.dart';
import 'my_account/my_account.dart';
import 'dart:math' as math;

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MenuProvider>();
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldKey,
        drawer: MenuDrawer(provider: provider),
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            leading: const Padding(
              padding:  EdgeInsets.only(top: 16.0),
            ),
            title:  Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16.sp),
              ).tr(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                        },
                        child: Image.asset(
                          "assets/task/notification_vector.png",
                          height: 50.h,
                          width: 45.w,
                        ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAccount()));
                      },
                      child:  ClipOval(
                        child: CachedNetworkImage(
                          height: 50.h,
                          width: 40.w,
                          fit: BoxFit.cover,
                          imageUrl: "${provider.profileImage}",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(color: AppColors.backgroundColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                provider.menuList?.isNotEmpty == true ? Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                        children: List.generate(provider.menuList?.length ?? 0, (index) {
                        final data = provider.menuList![index];
                        return UpdatedMenuDashboardCard(
                          onPressed: () => provider.getRoutSlag(context, data.slug, false),
                          title: data.name,
                          image: data.icon,
                      );;
                    }),
                  ),
                ) : Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: List.generate(20, (index) {
                        return Shimmer.fromColors(
                          baseColor: const Color(0xFFE8E8E8),
                          highlightColor: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ))],
            )));
  }
}
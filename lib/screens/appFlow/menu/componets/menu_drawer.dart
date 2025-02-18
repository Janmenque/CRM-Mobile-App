import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/language/language_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/privacy_policy/privacy_policy_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/support_policy/support_policy_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/terms_conditions/terms_conditions_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_summary/leave_summary.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../home/home_provider.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key, this.provider}) : super(key: key);

  final MenuProvider? provider;

  @override
  Widget build(BuildContext context) {
    List<MenuDrawerModel> accountList = [
      MenuDrawerModel(
          title: 'Leave'.tr(),
          iconData: 'assets/menu_drawer_icons/leave.svg',
          onTap: () => NavUtil.navigateScreen(context, const LeaveSummary())),
    ];

    List<MenuDrawerModel> settingList = [
      MenuDrawerModel(
          title: tr("language_change"),
          iconData: 'assets/menu_drawer_icons/language-change.svg',
          onTap: () => NavUtil.navigateScreen(context, const LanguageScreen())),
    ];

    List<MenuDrawerModel> supportList = [
      MenuDrawerModel(
          title: tr("support_policy"),
          iconData: 'assets/menu_drawer_icons/support-policy.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const SupportPolicyScreen())),
      MenuDrawerModel(
          title: tr("privacy_policy"),
          iconData: 'assets/menu_drawer_icons/privacy-policy.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const PrivacyPolicyScreen())),
      MenuDrawerModel(
          title: tr("terms_conditions"),
          iconData: 'assets/menu_drawer_icons/terms-condition.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const TermsConditionsScreen())),
      MenuDrawerModel(
        title: tr("Logout"),
        iconData: 'assets/menu_drawer_icons/logout.svg',
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(tr("are_you_sure_you_want_to_logout")),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(tr("no"))),
              TextButton(
                  onPressed: () async {
                    provider?.logOutFunctionality(context);
                  },
                  child: Text(tr("yes"))),
            ],
          ),
        ),
      ),
    ];
    return Consumer<HomeProvider>(
      builder: (BuildContext context, provider, _) {
        return Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  color: AppColors.colorPrimary,
                  child: Column(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: "${provider.profileImage}",
                          placeholder: (context, url) => Center(
                            child:
                                Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.verified),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            provider.userName ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'account',
                        style: TextStyle(color: Colors.grey),
                      ).tr(),
                      const Divider(),
                      Column(
                        children: accountList
                            .map((e) => buildDrawerListTile(
                            title: e.title,
                            iconData: e.iconData,
                            onTap: e.onTap))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Setting',
                        style: TextStyle(color: Colors.grey),
                      ).tr(),
                      const Divider(),

                      
                      Column(
                        children: settingList
                            .map((e) => buildDrawerListTile(
                            title: e.title,
                            iconData: e.iconData,
                            onTap: e.onTap))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Support',
                        style: TextStyle(color: Colors.grey),
                      ).tr(),
                      const Divider(),
                      Column(
                        children: supportList
                            .map((e) => buildDrawerListTile(
                            title: e.title,
                            iconData: e.iconData,
                            onTap: e.onTap))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                )
              ],
            ),
          ),
        );
      });
  }

  ListTile buildDrawerListTile(
      {String? title, Function()? onTap, String? iconData}) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(iconData ?? ''),
      title: Text(title ?? ''),
    );
  }
}

class MenuDrawerModel {
  String? title;
  String? iconData;
  Function()? onTap;

  MenuDrawerModel({this.title, this.iconData, this.onTap});
}


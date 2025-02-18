import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_build_profile_details.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/edit_official_info.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/office_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'change_password/change_password_profile.dart';

class OfficeTab extends StatelessWidget {
  final ResponseOfficialInfo? officialInfo;

  const OfficeTab({Key? key, this.officialInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfficeTabProvider(),
      child: Consumer<OfficeTabProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    provider.pickImage(context);
                  },
                  child: Center(
                      child: Stack(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          imageUrl: provider.profileImage ??
                              "https://www.w3schools.com/howto/img_avatar.png",
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                                "assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 0,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildProfileDetails(
                    title: tr("name"),
                    description: officialInfo?.data?.name ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("email"),
                    description: officialInfo?.data?.email ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("designation"),
                    description: officialInfo?.data?.designation ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("department"),
                    description: officialInfo?.data?.department ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("manager"),
                    description: officialInfo?.data?.manager ?? tr("n/a")),
                buildProfileDetails(
                  title: tr("date_of_joining"),
                  description: officialInfo?.data?.joiningDate ?? tr("n/a"),
                ),
                buildProfileDetails(
                    title: tr("employee_type"),
                    description: officialInfo?.data?.employeeType ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("employee_id"),

                    description: officialInfo?.data?.employeeId ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("grade"),
                    description: officialInfo?.data?.grade ?? tr("n/a")),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      NavUtil.navigateScreen(
                          context,
                          EditOfficialInfo(
                            officialInfo: officialInfo,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child:  Text(tr("edit_official_info"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      NavUtil.navigateScreen(context, const ChangePasswordProfile());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorPrimary,
                        shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                        ),
                    ),
                    child:  Text(tr("change_password"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

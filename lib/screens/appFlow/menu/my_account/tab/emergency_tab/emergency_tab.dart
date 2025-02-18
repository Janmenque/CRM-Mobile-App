import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_build_profile_details.dart';
import 'package:hrm_app/data/model/response_emergency.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/emergency_tab/edit_emergency_info/edit_emergency_info.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'emergency_provider.dart';

class EmergencyTeb extends StatelessWidget {
  final ResponseEmergency? emergencyInfo;

  const EmergencyTeb({Key? key, this.emergencyInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmergencyProvider(),
      child: Consumer<EmergencyProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Stack(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                        imageUrl: "${provider.profileImage}",
                        placeholder: (context, url) => Center(
                          child: Image.asset("assets/images/placeholder_image.png"),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                buildProfileDetails(
                    title: tr("name"),
                    description: emergencyInfo?.data?.emergencyName ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("mobile"),
                    description:
                        emergencyInfo?.data?.emergencyMobileNumber ?? tr("n/a")),
                buildProfileDetails(
                    title: tr("relationship"),
                    description:
                        emergencyInfo?.data?.emergencyMobileRelationship ??
                            tr("n/a")),
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
                          EditEmergencyInfo(
                            emergencyInfo: emergencyInfo,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child:  Text(tr("edit_personal_info"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

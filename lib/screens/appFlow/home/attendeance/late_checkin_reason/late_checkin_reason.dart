import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'late_checkin_reason_provider.dart';

class LateCheckInReason extends StatelessWidget {
  final int? remoteModeType;
  final String? currentDateSever;
  final String? currentTimeServer;
  final String? youLocationServer;
  final String? latitudeServer;
  final String? longitudeServer;
  final String? cityServer;
  final String? countryCodeServer;
  final String? countryServer;
  final String? checkStatus;
  final int? attendanceCheckInID;
  final String? attendanceMethod;
  final String? qrCode;

  const LateCheckInReason(
      {Key? key,
      this.remoteModeType,
      this.currentDateSever,
      this.currentTimeServer,
      this.youLocationServer,
      this.latitudeServer,
      this.longitudeServer,
      this.cityServer,
      this.countryCodeServer,
      this.countryServer,
      this.checkStatus,
      this.attendanceCheckInID,
      this.attendanceMethod,
      this.qrCode
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => LateCheckInReasonProvider(attendanceMethod),
        child: Consumer<LateCheckInReasonProvider>(
          builder: (context, provider, _) {
            return WillPopScope(
              onWillPop: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogEmptyField(
                        title: tr("please_provide_a_reason"),
                        subTitle: tr("could_you_please_provide_a_reason"),
                      );
                    });
                return Future(() => false);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    tr("late_reason"),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("share_your_late_attendance_reason"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: provider.lateCheckInController,
                        maxLines: 5,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: tr("write_reason"),
                          hintStyle: const TextStyle(fontSize: 14),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            checkStatus == "Check In"
                                ? provider.checkInApi(
                                    context,
                                    remoteModeType,
                                    currentDateSever,
                                    currentTimeServer,
                                    youLocationServer,
                                    latitudeServer,
                                    longitudeServer,
                                    cityServer,
                                    countryCodeServer,
                                    cityServer,
                                    qrCode)
                                : provider.checkOutApi(
                                    context,
                                    remoteModeType,
                                    currentDateSever,
                                    currentTimeServer,
                                    youLocationServer,
                                    latitudeServer,
                                    longitudeServer,
                                    cityServer,
                                    countryCodeServer,
                                    cityServer,
                                    attendanceCheckInID);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.colorPrimary),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          child: Text(tr("submit"),
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

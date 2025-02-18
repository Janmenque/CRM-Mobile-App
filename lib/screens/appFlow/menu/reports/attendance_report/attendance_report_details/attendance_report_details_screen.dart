import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_report_details/attendance_report_details_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AttendanceReportDetails extends StatelessWidget {
  const AttendanceReportDetails({Key? key, this.endpoint, this.date})
      : super(key: key);
  final String? endpoint;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceReportDetailsProvider(endpoint!, date!),
      child: Consumer<AttendanceReportDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF00CCFF),
                        AppColors.colorPrimary,
                      ],
                      begin: FractionalOffset(3.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              title: Text(
                tr('attendance_report_details'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.appBarColor),
              ),
            ),

            body: provider.isLoading
                ? provider.attendanceListResponse!.data!.users!.isNotEmpty
                    ? ListView.separated(
                        itemCount: provider
                                .attendanceListResponse?.data?.users?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider
                              .attendanceListResponse?.data?.users?[index];
                          return ListTile(
                            leading: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.network(
                                '${data?.avatar}',fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              data?.name ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(data?.designation ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.checkIn ?? '',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(data?.checkOut ?? '',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      )
                    :  Center(
                        child: Text(
                      tr('no_data_found'),
                      style: const TextStyle(
                          color: Color(0x65555555),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ))
                : const SizedBox(),
          );
        },
      ),
    );
  }
}

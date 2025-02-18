import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_details/appointment_details_provider.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsScreen extends StatelessWidget {

  const AppointmentDetailsScreen({super.key, this.appointmentId});

  final int? appointmentId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          AppointmentDetailsProvider(appointmentId!),
      child: Consumer<AppointmentDetailsProvider>(
        builder: (context, provider, _) {
          final data = provider.appointmentDetails?.data;
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("appointment_details")),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  buildContainer(
                      title: tr("description"), titleValue: data?.title ?? ''),
                  buildContainer(title: tr("date"), titleValue: data?.date ?? ''),
                  buildContainer(title: tr("time"), titleValue: data?.time ?? ''),
                  buildContainer(
                      title: tr("location"), titleValue: data?.location ?? ''),
                  buildContainer(title: tr("day"), titleValue: data?.day ?? ''),
                  buildContainer(
                      title: tr("start_time"), titleValue: data?.startAt ?? ''),
                  buildContainer(
                      title: tr("end_time"), titleValue: data?.endAt ?? ''),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(data?.appoinmentWith ?? ''),
                      children: [
                        buildContainer(
                            title: tr("agree"),
                            titleValue: data?.otherParticipant?.isAgree ?? ''),
                        buildContainer(
                            title: tr("present"),
                            titleValue: data?.otherParticipant?.isPresent ?? ''),
                        buildContainer(
                            title: tr("present_at"),
                            titleValue: data?.otherParticipant?.presentAt ?? ''),
                        buildContainer(
                            title: tr("appointment_start_at"),
                            titleValue: data?.otherParticipant?.appoinmentStartedAt ?? ''),
                        buildContainer(
                            title: tr("appointment_end_at"),
                            titleValue: data?.otherParticipant?.appoinmentEndedAt ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildContainer(
      {String? title,
      String? titleValue,
      Function()? onPressed,
      bool iconVisibility = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(title ?? '')),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    titleValue ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                  ),
                ),
                Visibility(
                  visible: iconVisibility,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: onPressed,
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

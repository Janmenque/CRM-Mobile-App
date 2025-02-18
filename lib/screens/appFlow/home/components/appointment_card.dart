import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/home/components/upcoming_event_widgetg.dart';
import 'package:hrm_app/screens/appFlow/home/home_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({Key? key, required this.provider}) : super(key: key);

  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/new_Appointment_bg.png',
            height: 185,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(tr("appointments"),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            letterSpacing: 0.5)).tr(),
                    TextButton(
                      onPressed: () => NavUtil.navigateScreen(
                          context, const AppointmentScreen()),
                      child:  Text(
                        tr("view_all"),
                        style: const TextStyle(
                            fontSize: 12, decoration: TextDecoration.underline),
                      ).tr(),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Column(
                  children: provider.appointmentsItems!
                      .map(
                        (e) => EventWidgets(
                          data: e,
                          isAppointment: true,
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

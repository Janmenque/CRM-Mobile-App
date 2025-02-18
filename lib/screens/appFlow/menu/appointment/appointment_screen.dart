import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/home/components/upcoming_event_widgetg.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_details/appointment_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/appointment_create/appointment_create_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppointmentProvider(),
      child: Consumer<AppointmentProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: () async {
              provider.getAppointmentList();
            },
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.colorPrimary,
                onPressed: () => NavUtil.navigateScreen(
                    context, const AppointmentCreateScreen()),
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title:  Text(tr("appointment_list")),
              ),
              body: Column(
                children: [
                  InkWell(
                    onTap: (){
                      provider.selectDate(context);
                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.selectDate(context);
                          },
                          icon: const FaIcon(FontAwesomeIcons.angleLeft,
                              size: 30, color: AppColors.colorPrimary),
                        ),
                        const Spacer(),
                        Center(
                            child: Text(
                          "${provider.monthYear}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            provider.selectDate(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 30,
                            color: AppColors.colorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  provider.isLoading == true
                      ? provider.appointmentListModel!.data!.items!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: provider.appointmentListModel?.data
                                        ?.items?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider.appointmentListModel
                                      ?.data?.items![index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: InkWell(
                                        onTap: () => NavUtil.navigateScreen(
                                            context,
                                            AppointmentDetailsScreen(
                                              appointmentId: data?.id,
                                            )),
                                        child: EventWidgets(
                                            isAppointment: true, data: data!),
                                      ));
                                },
                              ),
                            )
                          :  Expanded(
                              child: Center(
                                  child: Text(
                                tr("no_appointment_found"),
                                style: const TextStyle(
                                    color: Color(0x65555555),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              )),
                            )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

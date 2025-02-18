import 'package:flutter/material.dart';
import '../../../../data/model/response_meeting_list.dart';
import '../../../../utils/res.dart';

class EventWidgets extends StatelessWidget {
  const EventWidgets({Key? key, required this.data, this.isAppointment = false, this.viewAllPressed})
      : super(key: key);

  final Item data;

  ///is Appointment use coz of extra data and location filed
  ///Event, has no time and date field
  final bool? isAppointment;

  final Function()? viewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
      )),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.date}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('${data.day}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 0.5)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: VerticalDivider(
                color: AppColors.colorPrimary,
                thickness: 2,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                  Visibility(
                    visible: isAppointment!,
                    child: Row(
                      children: [
                        Text(
                          '${data.time},',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              letterSpacing: 0.5),
                        ),
                        Expanded(
                          child: Text(
                            ' ${data.location ?? ""} ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF555555),
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

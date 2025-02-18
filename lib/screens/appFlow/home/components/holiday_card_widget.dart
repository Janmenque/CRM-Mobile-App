import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/event_holiday_model/event_holiday_model.dart';
import '../../../../utils/res.dart';

class HolidayWidgets extends StatelessWidget {
  const HolidayWidgets({Key? key, this.upcomingItems, this.viewAllPressed})
      : super(key: key);

  // final data;
  final Item? upcomingItems;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${upcomingItems!.date}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('${upcomingItems!.day}',
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
              padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                    '${upcomingItems!.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

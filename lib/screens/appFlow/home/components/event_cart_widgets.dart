import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/home/statics_model.dart';
import 'package:hrm_app/utils/res.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.data, this.days = false, this.onPressed})
      : super(key: key);

  final  Today data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: SizedBox(
              width: 125,
              child: Column(
                children: [
                  Image.network(
                    '${data.image}',
                    height: 25,
                    color: AppColors.colorPrimary,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(tr("${data.number ?? 0}"),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                      if (days == true)
                         Text(
                          tr("days"),
                          style: const TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 4,
                              letterSpacing: 0.5),
                        ),
                    ],
                  ),
                  Text(tr("${data.title }")
                    ,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

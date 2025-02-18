import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReportLeaveApprovalScreen extends StatelessWidget {
  const ReportLeaveApprovalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('approval')),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "${tr('requested_for')} ",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                           "5",
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: Text(
                                    tr("approved"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

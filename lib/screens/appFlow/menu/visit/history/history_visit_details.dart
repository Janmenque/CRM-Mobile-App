import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/history/history_visit_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/history/line_status.dart';
import 'package:provider/provider.dart';

import 'history_details_google_map.dart';

class HistoryVisitDetails extends StatelessWidget {
  const HistoryVisitDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryVisitDetailsProvider(),
      child: Consumer<HistoryVisitDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Visit Details'),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "january 27, 2022",
                          style: TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            strokeWidth: 1,
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Test 1",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
                    const Text(
                      "Location",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: HistoryDetailsGoogleMap(),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: (){
                        provider.goToPosition(LatLng(
                            double.parse("23.791119"),
                            double.parse("90.406719")));

                      },

                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.blue[50],
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              "Visit Rescheduled",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Nandan Rosemont,House 148, Road 13/b,Block E,Banani,Dhaka"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "05 Mar,2022,05:32",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        provider.goToPosition(LatLng(
                            double.parse("23.750140"),
                            double.parse("90.390452")));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.blue[50],
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              "Visit Rescheduled",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Nandan Rosemont,House 148, Road 13/b,Block E,Banani,Dhaka"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "05 Mar,2022,05:32",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const LineStatus()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class LineStatus extends StatelessWidget {
  const LineStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FixedTimeline.tileBuilder(
        builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) => const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Visit Rescheduled Nandan Rosemont,House 148, Road 13/b,Block E,Banani,Dhaka 05 Mar,2022,05:32"),
            ),
          ),
          connectorStyleBuilder: (context, index) => ConnectorStyle.dashedLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemCount: 3,
        ),
      ),
    );
  }
}
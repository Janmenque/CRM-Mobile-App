
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/indicator.dart';
import '../../utils/res.dart';

class SalesPieChart extends StatefulWidget {
  const SalesPieChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: [
          Card(
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.3,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 60.r,
                              sections: showingSections(),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Indicator(
                        color: Color(0xff29D697),
                        text: 'Attendance',
                        isSquare: false,
                        size: 10,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const Indicator(
                        color: Color(0xfff8b250),
                        text: 'Class Test',
                        isSquare: false,
                        size: 10,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const Indicator(
                        color: Color(0xff845bef),
                        text: 'Mid Exam',
                        size: 10,
                        isSquare: false,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Positioned(
              top: 78.h,
              left: 144.w,
              bottom: 0.h,
              right: 0.w,
              child: const  Text("73%",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 32),),),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 15.0 : 10.0;
      final radius = isTouched ? 30.0 : 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.yellow,
            showTitle: false,
            value: 20,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 20,
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.black.withOpacity(.05),
            value: 20,
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 20,
            showTitle: false,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
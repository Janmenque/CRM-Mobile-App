import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String title;
  final String assetImage;

  const NoDataFoundWidget(
      {super.key,
        this.title = 'No Data Found',
        this.assetImage = 'assets/images/no_data_found.json'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
        child: Column(
        children: [
          const SizedBox(height: 20),
          Center(child: Lottie.asset(assetImage, repeat: false, height:  200)),
          Center(
            child: Text(title.trim(),
            style: TextStyle(color: AppColors.colorPrimary.withOpacity(0.4), fontSize: 18, fontWeight: FontWeight.w500),),
        ),
      ],
    ));
  }
}

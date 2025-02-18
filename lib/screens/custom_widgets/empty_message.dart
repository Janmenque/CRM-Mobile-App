import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/res.dart';

class EmptyMessageWidget extends StatelessWidget {
  const EmptyMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/images/no_data_found.json", repeat: false, height:  200),
          Text("No Data Found".trim(),
            style: TextStyle(color: AppColors.colorPrimary.withOpacity(0.4), fontSize: 18, fontWeight: FontWeight.w500),),

        ],
      ),
    );
  }
}

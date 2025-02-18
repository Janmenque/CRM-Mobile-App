import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';
import 'components/history_card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Income",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                  width: double.infinity,
                  child: Text(
                    "Transactions history",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const HistoryCard(
              image: 'assets/stocks/upwork.png',
              title: "Upwork",
              amount: "+ \$ 850.00",
              color: Color(0xff25A969),
            ),
            const HistoryCard(
              image: 'assets/stocks/paypal.png',
              title: "Paypal",
              amount: "+ \$ 850.00",
              color: Color(0xff25A969),
            ),
          ],
        ),
      ),
    );
  }
}

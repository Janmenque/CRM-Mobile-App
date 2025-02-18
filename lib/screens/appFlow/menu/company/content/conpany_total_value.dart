import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/utils/res.dart';
import '../../../../custom_widgets/company_dashboard_card.dart';

class CompanyTotalValue extends StatelessWidget {
  const CompanyTotalValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          CompanyDashboardCard(
            cardColor: AppColors.primaryColor.withOpacity(0.2),
            textColor: AppColors.black.withOpacity(0.7),
            title: "Contact Company",
            count: "500",
          ),
          CompanyDashboardCard(
            cardColor: AppColors.primaryColor.withOpacity(0.2),
            textColor: AppColors.black.withOpacity(0.7),
            title: "Contact Company",
            count: "500",
          ),
          CompanyDashboardCard(
            cardColor: AppColors.primaryColor.withOpacity(0.2),
            textColor: AppColors.black.withOpacity(0.7),
            title: "Contact Company",
            count: "500",
          ),
          CompanyDashboardCard(
            cardColor: AppColors.primaryColor.withOpacity(0.2),
            textColor: AppColors.black.withOpacity(0.7),
            title: "Contact Company",
            count: "500",
          ),
        ],
      ),
    );
  }
}

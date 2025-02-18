import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/view/campaign_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/view/coupon_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/discount/view/discount_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/view/service_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sales_dashboard/content/sales_dashboard_card.dart';


class BookingDashboardScreen extends StatelessWidget {
  const BookingDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Booking Dashboard", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            children: [
              SalesDashboardCard(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const ServiceListScreen())),
                  title: 'Service', image: "assets/images/adjustment.png"),
              SalesDashboardCard(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscountListScreen())),
                  title: 'Discount', image: "assets/images/stock.png"),
              SalesDashboardCard(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CampaignListScreen())),
                  title: 'Campaign', image: "assets/images/purchase.png"),
              SalesDashboardCard(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CouponListScreen())),
                  title: 'Coupon', image: "assets/images/sales.png"),
            ]),
      ),
    );
  }
}


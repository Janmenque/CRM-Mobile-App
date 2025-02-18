import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/view/adjustment_list.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/biller/view/biller_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/customer/view/customer_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/view/product_list.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/view/purchase_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/quotation/view/quotation_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/view/sale_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sales_dashboard/content/sales_dashboard_card.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/view/stcok_management_list.dart';


class SalesDashboardScreen extends StatelessWidget {
  const SalesDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Sales Dashboard", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          children: [
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen())),
              title: 'Product', image: "assets/images/product.png",),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const AdjustmentListScreen())),
              title: 'Adjustment', image: "assets/images/adjustment.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const StockManagementListScreen())),
              title: 'Stocks', image: "assets/images/stock.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseListScreen())),
              title: 'Purchase', image: "assets/images/purchase.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const SaleListScreen())),
              title: 'Sales', image: "assets/images/sales.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const QuotationListScreen())),
              title: 'Quotation', image: "assets/images/quotation.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const BillerListScreen())),
              title: 'Biller', image: "assets/images/biller.png"),
            SalesDashboardCard(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerListScreen())),
              title: 'Customer', image: "assets/images/customer.png"),
          ]),
        ),
    );
  }
}


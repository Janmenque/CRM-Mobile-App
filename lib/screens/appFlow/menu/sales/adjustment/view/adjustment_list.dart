import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/content/adjustment_list_card.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/provider/adjustment_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/view/create_adjustment.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/product_create_and_search_content.dart';
import 'package:hrm_app/screens/custom_widgets/title_with_length.dart';
import 'package:provider/provider.dart';

class AdjustmentListScreen extends StatelessWidget {
  const AdjustmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdjustmentListProvider>(
      builder: (context, provider, _) {
        final adjustments = provider.adjustmentResponse?.data?.adjustments;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Adjustment List", style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              InkWell(
                onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateAdjustmentScreen())),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                  margin: EdgeInsets.symmetric( horizontal: 15.w),
                  decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8.r)),
                  child: Icon(Icons.add, size: 16.sp, color: Colors.white,),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleAndLength(title: "Adjustment", length: adjustments?.length ?? 0,),
                  AdjustmentList(provider: provider)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
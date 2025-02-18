import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/view/create_resource_plan_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/resource_plan_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class CreateResourcePlanWidget extends StatelessWidget {
  ResourcePlanProvider? provider;
  CreateResourcePlanWidget({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Resource Plan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          InkWell(
            onTap: ()=> NavUtil.navigateScreen(context, const CreateResourcePlanScreen()),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(color: const Color(0xff5B58FF), borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Icon(Icons.add, size: 14, color: Colors.white,),
                  Text("Create", style: TextStyle(color: Colors.white, fontSize: 12),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
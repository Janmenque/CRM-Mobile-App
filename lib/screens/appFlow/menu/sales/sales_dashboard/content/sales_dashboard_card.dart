
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class SalesDashboardCard extends StatelessWidget {
  const SalesDashboardCard({
    super.key, this.title, this.image, this.onTap
  });
 final String? title;
 final String? image;
 final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset( image ?? "assets/images/product.png", height: 20, width: 20,)),
            const SizedBox(height: 10),
            Text( title ?? "", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
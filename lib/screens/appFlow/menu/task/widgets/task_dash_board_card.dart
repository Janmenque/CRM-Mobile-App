import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({Key? key, this.title, this.image, this.textColor})
      : super(key: key);

  final String? title, image;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              image ?? "",
              height: 24,
              width: 24,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.black,
                  fontSize: 16),
            ).tr()
          ],
        ),
      ),
    );
  }
}
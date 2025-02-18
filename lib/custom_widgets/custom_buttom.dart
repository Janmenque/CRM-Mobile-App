import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? clickButton;

  const CustomButton({Key? key, this.title, this.clickButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (clickButton != null) clickButton!();
        },
        style:ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
        ),
        child: Text("$title",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
      ),
    );
  }
}

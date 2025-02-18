import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class CustomDashBoardAppbar extends StatelessWidget {
  const CustomDashBoardAppbar(
      {Key? key,
      this.leadingImage,
      this.notification,
      this.userImage,
      this.title})
      : super(key: key);

  final String? leadingImage, notification, userImage, title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: InkWell(
          onTap: (){
          },
          child: Image.asset(
            leadingImage ?? "",
            height: 40,
            width: 40,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title ?? "",
          style:
              const TextStyle(color: AppColors.black, fontWeight: FontWeight.bold,fontSize: 16),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16),
          child: Row(
            children: [
              Image.asset(
                notification ?? "",
                height: 50,
                width: 45,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                userImage ?? "",
                height: 40,
                width: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

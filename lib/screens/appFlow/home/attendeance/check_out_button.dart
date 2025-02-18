import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatefulWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  CheckOutButtonState createState() => CheckOutButtonState();
}

class CheckOutButtonState extends State<CheckOutButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.addListener(() {
      setState(() {
        if (kDebugMode) {
          print("${controller.value.toInt()}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          controller.forward();
        },
        onTapUp: (_) {
          if (controller.status == AnimationStatus.forward) {
            controller.reverse();
            controller.value;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const SizedBox(
              height: 175,
              width: 175,
              child: CircularProgressIndicator(
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(
              height: 185,
              width: 185,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                value: controller.value,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
             ClipOval(
              child: Material(
                  color: Colors.blue,
                  child: SizedBox(
                    height: 170,
                    width: 170,
                    child: Center(
                      child: Text(
                        tr("check-out"),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25,),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
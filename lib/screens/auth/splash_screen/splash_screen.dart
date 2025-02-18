import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/custom_widgets/animation/bounce_animation/bounce_animation_builder.dart';
import 'package:hrm_app/screens/auth/splash_screen/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => SplashProvider(context),
    child: Consumer<SplashProvider>(
      builder: (context,provider,_){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BounceAnimationBuilder(
                    builder: (_,__){
                      return Center(
                        child: InteractiveViewer(
                          scaleEnabled: false,
                          boundaryMargin:  EdgeInsets.symmetric(horizontal: 16.w),
                          child: Image.asset(
                            "assets/images/splash_logo.png",
                            scale: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
        );
      },
    ),);
  }
}


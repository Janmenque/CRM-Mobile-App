import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/screens/auth/forget_password/forget_password.dart';
import 'package:hrm_app/screens/auth/login/login_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: context.watch<LoginProvider>().scaffoldKey,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Thank you for your return",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: const Color(0xff8E8E93),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller:
                          context.watch<LoginProvider>().emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: tr("email"),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Visibility(
                        visible: context.watch<LoginProvider>().email != null,
                        child: Text(
                          context.watch<LoginProvider>().email ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                    Visibility(
                        visible: context.watch<LoginProvider>().error != null &&
                            context.watch<LoginProvider>().email == null &&
                            context.watch<LoginProvider>().password == null,
                        child: Text(
                          context.watch<LoginProvider>().error ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller:
                          context.watch<LoginProvider>().passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText:
                          !context.read<LoginProvider>().passwordVisible,
                      decoration: InputDecoration(
                        labelText: tr("password"),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(
                            context.watch<LoginProvider>().passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.colorPrimary,
                          ),
                          onPressed: () {
                            context.read<LoginProvider>().passwordVisibility();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Visibility(
                        visible:
                            context.watch<LoginProvider>().password != null,
                        child: Text(
                          context.watch<LoginProvider>().password ?? "",
                          style: const TextStyle(color: Colors.red),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      title: tr("login"),
                      clickButton: () {
                        context.read<LoginProvider>().getUserInfo(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<LoginProvider>().resetTextField();
                        NavUtil.navigateScreen(context, const ForgetPassword());
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tr("forgot_password"),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/auth/forget_password/forget_pass_provider.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              tr("forget_password"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("enter_your_email_address_to_reset_your_password"),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller:
                      context.watch<ForgetPassProvider>().emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: tr("enter_your_email"),
                    labelStyle: const TextStyle(fontSize: 12),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                    visible:
                        context.watch<ForgetPassProvider>().emailError != null,
                    child: Text(
                      context.watch<ForgetPassProvider>().emailError ?? "",
                      style: const TextStyle(color: Colors.red),
                    )),
                Visibility(
                    visible: context.watch<ForgetPassProvider>().error !=
                            null &&
                        context.watch<ForgetPassProvider>().emailError == null,
                    child: Text(
                      context.watch<ForgetPassProvider>().error ?? "",
                      style: const TextStyle(color: Colors.red),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ForgetPassProvider>()
                          .getVerificationCode(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(tr("send_verification_code"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

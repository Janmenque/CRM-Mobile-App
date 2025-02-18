import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/auth/forget_password/forget_password.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

import 'change_password_profile_provider.dart';

class ChangePasswordProfile extends StatelessWidget {
  const ChangePasswordProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passKey = GlobalKey<FormFieldState>();
    final provider = context.watch<ChangePasswordProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("change_password")
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: provider.currentPassTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !provider.passwordVisible,
                decoration:  InputDecoration(
                  labelText: tr("change_password"),
                  labelStyle: const TextStyle(fontSize: 12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          provider.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          provider.passwordVisibility();
                        },
                      ),
                ),
              ),
              Visibility(
                  visible: provider.currentPassError != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      provider.currentPassError ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              Visibility(
                  visible: provider.error != null &&
                      provider.currentPassError == null &&
                      provider.newPasswordError == null &&
                      provider.passwordConfirmationError == null,
                  child: Text(
                    provider.error ?? "",
                    style: const TextStyle(color: Colors.red),
                  )),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                key: passKey,
                controller: provider.newPasswordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !provider.passwordVisible,
                decoration:  InputDecoration(
                  labelText: tr("new_password"),
                  labelStyle: const TextStyle(fontSize: 12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      provider.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      provider.passwordVisibility();
                    },
                  ),
                ),
              ),
              Visibility(
                  visible: provider.newPasswordError != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      provider.newPasswordError ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: provider.reTypePasswordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !provider.passwordVisible,
                decoration:  InputDecoration(
                  labelText: tr("Re_type_new_password"),
                  labelStyle: const TextStyle(fontSize: 12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      provider.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      provider.passwordVisibility();
                    },
                  ),
                ),
              ),
              Visibility(
                  visible: provider.passwordConfirmationError != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      provider.passwordConfirmationError ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<ChangePasswordProfileProvider>()
                        .getChangePasswordProfile(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child:  Text(tr("change_password"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  NavUtil.navigateScreen(context, const ForgetPassword());
                },
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tr("forgot_password"),
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/auth/change_password/change_password_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  final String email;

  const ChangePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChangePasswordProvider>();
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
               Text(
                tr("reset_your_password"),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${tr("a_code_has_been_sent_to")} ${widget.email} ${tr("use_the_code_here")}",
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(
                height: 26,
              ),
              TextField(
                controller: provider.enterCodeTextController,
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  labelText: tr("enter_code"),
                  labelStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              Visibility(
                  visible:
                      context.watch<ChangePasswordProvider>().errorCode != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      context.watch<ChangePasswordProvider>().errorCode ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              Visibility(
                  visible: context.watch<ChangePasswordProvider>().errorMessage !=
                          null &&
                      context.watch<ChangePasswordProvider>().errorEmail ==
                          null &&
                      context
                              .watch<ChangePasswordProvider>()
                              .errorPassword ==
                          null &&
                      context
                              .watch<ChangePasswordProvider>()
                              .errorPasswordConfirmation ==
                          null &&
                      context.watch<ChangePasswordProvider>().errorCode == null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      context.watch<ChangePasswordProvider>().errorMessage ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: provider.confirmPassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: tr("new_password"),
                  labelStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                  visible:
                  context.watch<ChangePasswordProvider>().errorPassword != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      context.watch<ChangePasswordProvider>().errorPassword ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: provider.newPasswordTextController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'confirm_password',
                  labelStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                  visible:
                  context.watch<ChangePasswordProvider>().errorPasswordConfirmation != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      context.watch<ChangePasswordProvider>().errorPasswordConfirmation ?? "",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              const SizedBox(
                height: 26,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<ChangePasswordProvider>()
                        .getNewPassword(context, widget.email);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child:  Text(tr("reset_password"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

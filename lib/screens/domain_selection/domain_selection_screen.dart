import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/domain_selection/domain_provider.dart';
import 'package:provider/provider.dart';
import '../../custom_widgets/custom_buttom.dart';

class DomainSelectionScreen extends StatelessWidget {
  const DomainSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/domain.jpg", height: MediaQuery.of(context).size.height * 0.5, width: double.infinity,),
              const SizedBox(
                height: 10,
              ),
              Text("Enter your company domain * ", style: TextStyle(fontSize: 12.sp),),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60.h,
                child: TextField(
                  controller: context.read<DomainProvider>().domainUrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: tr("Ex : https://example.com"),
                    labelStyle: TextStyle(fontSize: 14.sp),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 20),
                child: CustomButton(
                  title: tr("Submit"),
                  clickButton: () {
                    context.read<DomainProvider>().addDomain(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

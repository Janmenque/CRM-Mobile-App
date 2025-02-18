import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/apply_leave/apply_leave_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({Key? key,required this.onBack}) : super(key: key);

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => ApplyLeaveProvider(),
      child: Consumer<ApplyLeaveProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("daily_leave")),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.leave?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: RadioListTile<LeaveTypeModel?>(
                          title: Text(provider.leave![index].title!),
                          value: provider.leave![index],
                          groupValue: provider.leaveType,
                          onChanged: (value) {
                            provider.setChecked(value);
                          }),
                    );
                  },
                ),

                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey)),
                  child: currentDate(provider, context),
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: provider.reasonController,
                    maxLines: 10,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: tr("write_reason"),
                      hintStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 16),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(formKey.currentState!.validate()){
                        final isApplied = await provider.applyLeave(context);
                        if(isApplied) {
                          onBack.call();
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child:  Text(
                      tr("apply"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InkWell currentDate(ApplyLeaveProvider provider, context) {
    return InkWell(
      onTap: () {
        provider.selectDate(context);
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 30,
                color: AppColors.colorPrimary,
              )),
          const Spacer(),
          Center(
              child: Text(
                provider.approxTime ?? tr("approximate_time"),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          const Spacer(),
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 30,
                color: AppColors.colorPrimary,
              )),
        ],
      ),
    );
  }
}

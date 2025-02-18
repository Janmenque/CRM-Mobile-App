import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'create_appreciate_provider.dart';

class CreateAppreciateScreen extends StatelessWidget {
  final int? appreciateId;
  const CreateAppreciateScreen({Key? key,this.appreciateId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateAppreciateProvider(),
      child: Consumer<CreateAppreciateProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(tr("appreciate_note")),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      tr("show_appreciation_for_your_teammate"),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: provider.appreciateTextController,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: tr("send_your_appreciation"),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.createAppreciateNoteApi(context, appreciateId);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(AppColors.colorPrimary),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child:  Text(tr("save"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

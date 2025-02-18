import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_cancel/visit_cancel_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class VisitCancelScreen extends StatelessWidget {

  final int? visitId;

  const VisitCancelScreen({Key? key,this.visitId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VisitCancelProvider(visitId),
      child: Consumer<VisitCancelProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                tr("visit_cancellation_reason")
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    tr("why_do_you_want_to_cancel_the_visit"),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: provider.cancelNoteTextController,
                    maxLines: 5,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: tr("write_a_cancellation_note"),
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
                        provider.changeStatusVisitApi(context);
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
                      child:  Text(tr("submit"),
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
          );
        },
      ),
    );
  }
}

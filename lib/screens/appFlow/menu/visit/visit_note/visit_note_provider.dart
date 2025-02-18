import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class VisitNoteProvider extends ChangeNotifier {
  var noteTextController = TextEditingController();

  VisitDetailsProvider? visitDetailsProvider;

  createNoteApi(context, int? visitId) async {
    if (noteTextController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogEmptyField(
              title: "Filed Empty",
              subTitle: "Give a note. Field cannot be empty",
            );
          });
    } else {
      var bodyCreateNote =
          BodyCreateNote(visitId: visitId, note: noteTextController.text);
      var apiResponse = await Repository.createNoteVisit(bodyCreateNote);
      if (apiResponse.result == true) {
        Fluttertoast.showToast(
            msg: apiResponse.data?.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
        notifyListeners();
        NavUtil.replaceScreen(
            context,
            VisitDetails(
              visitID: visitId,
            ));
      } else {
        Fluttertoast.showToast(
            msg: apiResponse.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        notifyListeners();
      }
    }
  }
}

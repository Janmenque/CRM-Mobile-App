import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class CreateAppreciateProvider extends ChangeNotifier{
  var appreciateTextController = TextEditingController();

  createAppreciateNoteApi(context, int? appreciateId) async {
    if (appreciateTextController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return  CustomDialogEmptyField(
              title: tr("filed_empty"),
              subTitle: tr("give_a_appreciate_note_field_cannot_be_empty"),
            );
          });
    } else {
      var bodyCreateAppreciate =
      BodyCreateAppreciate(appreciateTo: appreciateId, message: appreciateTextController.text);
      var apiResponse = await Repository.createAppreciateApi(bodyCreateAppreciate);
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
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: apiResponse.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
        notifyListeners();
      }
    }
  }

}
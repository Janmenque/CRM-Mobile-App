import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PosProvider extends ChangeNotifier{

  String? monthYear;
  DateTime? selectedDate;

  bool isChecked = false;



  void toggleCheckbox(bool value) {
    isChecked = value;
    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        monthYear = DateFormat('yyyy-MM-dd').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

}
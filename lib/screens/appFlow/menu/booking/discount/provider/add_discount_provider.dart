import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_booking_repository/crm_booking_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/discount/provider/discount_list_provider.dart';
import 'package:provider/provider.dart';

class CreateDiscountProvider with ChangeNotifier {

  DiscountCreateComponentListModel? discountComponentListResponse;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final minPurchaseController = TextEditingController();
  final maxPurchaseController = TextEditingController();

  String selectDiscountType = 'Category';

  String selectDiscountAmountType = "Percentage";

  List<DiscountComponent> selectedDiscountCategories = [];
  List<DiscountComponent> selectedDiscountServices = [];
  List<DiscountComponent> selectedDiscountZones = [];

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  CreateDiscountProvider(){
    getDiscountComponentList();
  }


  getDiscountComponentList() async {
    final response = await CrmBookingRepository.getCreateDiscountComponentListData();
    if(response.result == true){
      discountComponentListResponse = response.data;
    }
    notifyListeners();
  }



  void setSelectedDiscountType(String type) {
    selectDiscountType = type;
    notifyListeners();
  }


  void setSelectedDiscountAmountType(String type) {
    selectDiscountAmountType = type;
    notifyListeners();
  }


  void toggleCategory(DiscountComponent category) {
    if (selectedDiscountCategories.any((element) => element.id == category.id)) {
      selectedDiscountCategories.removeWhere((element) => element.id == category.id);
    } else {
      selectedDiscountCategories.add(category);
    }
    notifyListeners();
  }



  void toggleService(DiscountComponent service) {
    if (selectedDiscountServices.any((element) => element.id == service.id)) {
      selectedDiscountServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedDiscountServices.add(service);
    }
    notifyListeners();
  }



  void toggleZone(DiscountComponent zone){
    if(selectedDiscountZones.any((element) => element.id == zone.id)){
      selectedDiscountZones.removeWhere((element) => element.id == zone.id);
    } else {
      selectedDiscountZones.add(zone);
    }
    notifyListeners();
  }


  ////Select Start date
  Future selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedStartDate = pickedDate;
      startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
      notifyListeners();
    }
  }


  ///select end date
  Future selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: selectedStartDate!,
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedStartDate!,
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedEndDate = pickedDate;
      endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
      notifyListeners();
    }
  }



  Future createDiscount (context) async {
    final data = FormData.fromMap({
      "discount_type" : selectDiscountType,
      "title" : titleController.text,
      "category_id[]": selectedDiscountCategories.isNotEmpty ? selectedDiscountCategories.map((category) => category.id).toList() : null,
      "service_id[]": selectedDiscountServices.isNotEmpty ? selectedDiscountServices.map((service) => service.id).toList() : null,
      "zone_id[]": selectedDiscountZones.isNotEmpty ? selectedDiscountZones.map((zone) => zone.id).toList() : null,
      "discount_amount_type" : selectDiscountAmountType,
      "amount": amountController.text,
      "start_date" : startDate,
      "end_date" : endDate,
      "min_purchase_amount" : minPurchaseController.text,
      "max_purchase_amount" : maxPurchaseController.text,
    });
    final response = await CrmBookingRepository.postAddDiscount(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<DiscountListProvider>(context, listen: false).getDiscountList();
      Navigator.pop(context);
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }

    notifyListeners();
  }

}
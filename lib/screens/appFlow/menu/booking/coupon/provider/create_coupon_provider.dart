
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/coupon/coupon_customer_list_model.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_booking_repository/crm_booking_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/provider/coupon_list_provider.dart';
import 'package:provider/provider.dart';

class CreateCouponProvider with ChangeNotifier {

  DiscountCreateComponentListModel? discountComponentListResponse;

  CouponCustomerListModel? couponCustomerListResponse;

  List<CouponCustomer> selectedCustomers = [];

  final couponCodeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final minPurchaseController = TextEditingController();
  final maxPurchaseController = TextEditingController();
  final limitForSameUserController = TextEditingController();

  String selectDiscountType = 'Category';

  String selectDiscountAmountType = "Percentage";

  CouponType? couponType;

  List<DiscountComponent> selectedCouponCategories = [];
  List<DiscountComponent> selectedCouponServices = [];
  List<DiscountComponent> selectedCouponZones = [];

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  CreateCouponProvider(){
    getDiscountComponentList();
    getCouponCustomerList();
  }


  selectedCouponType(CouponType couponTypeValue){
    couponType = couponTypeValue;
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


  void toggleCustomer(CouponCustomer customer) {
    if (selectedCustomers.any((element) => element.id == customer.id)) {
      selectedCustomers.removeWhere((element) => element.id == customer.id);
    } else {
      selectedCustomers.add(customer);
    }
    notifyListeners();
  }


  void toggleCategory(DiscountComponent category) {
    if (selectedCouponCategories.any((element) => element.id == category.id)) {
      selectedCouponCategories.removeWhere((element) => element.id == category.id);
    } else {
      selectedCouponCategories.add(category);
    }
    notifyListeners();
  }


  void toggleService(DiscountComponent service) {
    if (selectedCouponServices.any((element) => element.id == service.id)) {
      selectedCouponServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedCouponServices.add(service);
    }
    notifyListeners();
  }



  void toggleZone(DiscountComponent zone){
    if(selectedCouponZones.any((element) => element.id == zone.id)){
      selectedCouponZones.removeWhere((element) => element.id == zone.id);
    } else {
      selectedCouponZones.add(zone);
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


  getDiscountComponentList() async {
    final response = await CrmBookingRepository.getCreateDiscountComponentListData();
    if(response.result == true){
      discountComponentListResponse = response.data;
    }
    notifyListeners();
  }


  getCouponCustomerList() async {
    final response = await CrmBookingRepository.getCouponCustomerListData();
    if(response.result == true){
      couponCustomerListResponse = response.data;
    }
    notifyListeners();
  }



  Future createCoupon (context) async {
    final data = FormData.fromMap({
      "coupon_type" : couponType?.name,
      "code" : couponCodeController.text,
      "discount_type" : selectDiscountType,
      "discount_title" : titleController.text,
      "discount_amount_type" : selectDiscountAmountType,
      "amount": amountController.text,
      "start_date" : startDate,
      "end_date" : endDate,
      "min_purchase_amount" : minPurchaseController.text,
      "max_purchase_amount" : maxPurchaseController.text,
      "category_id[]": selectedCouponCategories.isNotEmpty ? selectedCouponCategories.map((category) => category.id).toList() : null,
      "service_id[]": selectedCouponServices.isNotEmpty ? selectedCouponServices.map((service) => service.id).toList() : null,
      "zone_id[]": selectedCouponZones.isNotEmpty ? selectedCouponZones.map((zone) => zone.id).toList() : null,
      "customer_id[]": selectedCustomers.isNotEmpty ? selectedCustomers.map((customer) => customer.id).toList() : null,
    });
    final response = await CrmBookingRepository.postAddCoupon(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<CouponListProvider>(context, listen: false).getCouponList();
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
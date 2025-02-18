import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/model/lead/add_lead_all_component_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_list_provider.dart';
import 'package:provider/provider.dart';

class AddLeadProvider extends ChangeNotifier {

  String? monthYear;
  DateTime? selectedDate;


  final leadNameController = TextEditingController();
  final leadTitleController = TextEditingController();
  final leadCityController = TextEditingController();
  final leadZipCodeController = TextEditingController();
  final leadEmailController = TextEditingController();
  final leadStateController = TextEditingController();
  final leadWebsiteController = TextEditingController();
  final leadPhoneController = TextEditingController();
  final leadAddressController = TextEditingController();
  final leadDescriptionController = TextEditingController();

  AddLeadAllComponentModel? addLeadAllComponentResponse;

  CountryListModel? countryListResponse;
  Country? country;

  LeadComponent? leadType;
  LeadComponent? leadZone;
  LeadComponent? leadStatus;

  AddLeadProvider(){
    getAddLeadComponentList();
    getCountryList();
  }



  getAddLeadComponentList() async {
    final response = await CRMSalesRepository.getAddLeadAllComponentListData();
    if(response.result == true){
      addLeadAllComponentResponse = response.data;
      notifyListeners();
    }
  }

  getCountryList() async {
    final response = await CRMSalesRepository.getCountryListData();
    if(response.result == true){
      countryListResponse = response.data;
      notifyListeners();
    }
  }



  selectCountry(Country? countryValue){
    country = countryValue;
    notifyListeners();
  }

  selectLeadType(LeadComponent? leadTypeValue){
    leadType = leadTypeValue;
    notifyListeners();
  }

  selectLeadZone(LeadComponent? leadZoneValue){
    leadZone = leadZoneValue;
    notifyListeners();
  }

  selectLeadStatus(LeadComponent? leadStatusValue){
    leadStatus = leadStatusValue;
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
        monthYear = DateFormat('dd-MM-yyyy').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('dd-MM-yyyy').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }


  Future createLead(context) async {
    final data = FormData.fromMap({
      "name" : leadNameController.text,
      "title" : leadTitleController.text,
      "email" : leadEmailController.text,
      "phone" : leadPhoneController.text,
      "website" : leadWebsiteController.text,
      "city" : leadCityController.text,
      "state" : leadStateController.text,
      "country_id" : country?.id,
      "zip" : leadZipCodeController.text,
      "address" : leadAddressController.text,
      "lead_type_id" : leadType?.id,
      "lead_source_id" : leadZone?.id,
      "lead_status_id" :leadStatus?.id,
      "next_follow_up" : monthYear,
      'description' : leadDescriptionController.text,
    });
    final response = await CRMSalesRepository.postAddLead(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<LeadListProvider>(context, listen: false).getLeadList();
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
  }

}
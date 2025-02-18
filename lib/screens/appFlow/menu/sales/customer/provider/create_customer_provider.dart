import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/customer_group_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/customer/provider/customer_list_provider.dart';
import 'package:provider/provider.dart';

class AddCustomerProvider extends ChangeNotifier{

  final customerNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final taxController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();

  bool isBothCustomerAndSupplier = false;
  bool isAddUser = false;

  CustomerGroupListModel? customerGroupListResponse;
  CustomerGroup? customerGroup;

  CountryListModel? countryListResponse;
  Country? country;

  AddCustomerProvider(){
    getCustomerGroupList();
    getCountryList();
  }



  getCustomerGroupList() async {
    final response = await CRMSalesRepository.getCustomerGroupListData();
    if(response.result == true){
      customerGroupListResponse = response.data;
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


  selectCustomerGroup(CustomerGroup customerGroupValue){
    customerGroup = customerGroupValue;
    notifyListeners();
  }

  selectCountry(Country? countryValue){
    country = countryValue;
    notifyListeners();
  }



  void toggleCustomerAndSupplier(bool value){
    isBothCustomerAndSupplier = value;
    notifyListeners();
  }


  void toggleAddUser(bool value){
    isAddUser = value;
    notifyListeners();
  }


  Future addCustomer(context) async {
    final data = FormData.fromMap({
      "customer_group_id": customerGroup?.id,
      "customer_name": customerNameController.text,
      "company_name": companyNameController.text,
      "email": emailController.text,
      "phone_number": phoneController.text,
      "tax_no": taxController.text,
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "postal_code": postalCodeController.text,
      "country_id": country?.id,
      "is_user_create": isAddUser == true ? 1 : 0,
      "name": userNameController.text,
      "password": userPasswordController.text,
      "is_both_customer_supplier": isBothCustomerAndSupplier == true ? 1 : 0,

    });
    final response = await CRMSalesRepository.postAddCustomer(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<CustomerListProvider>(context, listen: false).getCustomerList();
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
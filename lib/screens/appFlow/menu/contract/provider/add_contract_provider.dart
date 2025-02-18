import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_list_provider.dart';
import 'package:provider/provider.dart';

class AddContractProvider extends ChangeNotifier{

  CrmCreateContractComponent? crmCreateContractComponentResponse;

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  ContractComponent? client;
  ContractComponent? contractType;
  List<ContractComponent> selectedServices = [];
  final subjectController = TextEditingController();
  final contractAmountController = TextEditingController();
  final contractDescriptionController = TextEditingController();

  bool isServiceBased = false;


  AddContractProvider(){
    getCrmCreateAllComponent();
  }



  selectClient(ContractComponent clientValue){
    client = clientValue;
    notifyListeners();
  }


  selectContractType(ContractComponent contractTypeValue){
    contractType = contractTypeValue;
    notifyListeners();
  }


  void toggleService(ContractComponent service) {
    if (selectedServices.any((element) => element.id == service.id)) {
      selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedServices.add(service);
    }
    notifyListeners();
  }

  void toggleServiceBased() {
    isServiceBased = !isServiceBased;
    //service = null;
    notifyListeners();
  }



  ////getCrmCreateAllComponent
  getCrmCreateAllComponent() async {
    final response = await CrmContractRepository.getContractAllComponentListData();
    if(response.result == true){
      crmCreateContractComponentResponse = response.data;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
      notifyListeners();
    }
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



  ///add contract
  Future addContract(context) async {
    final data = FormData.fromMap({
      "client_id": client?.id,
      "subject": subjectController.text,
      "contract_amount" : contractAmountController.text,
      "contract_type" : contractType?.id,
      "start_date" : startDate,
      "end_date" : endDate,
      "description" : contractDescriptionController.text,
      "is_service_base" : isServiceBased == true ? 1 : 0,
      "services[]": selectedServices.isNotEmpty ? selectedServices.map((service) => service.id).toList() : null,

    });
    final response = await CrmContractRepository.postAddContract(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<ContractListProvider>(context, listen: false).getAllContractList();
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
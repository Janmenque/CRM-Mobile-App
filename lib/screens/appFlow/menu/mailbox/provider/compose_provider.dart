import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/mailbox/compose_contract_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_estimate_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_invoice_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_lead_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_note_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_project_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_project_payment_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_proposal_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_sale_payment_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_task_list.dart';
import 'package:hrm_app/data/model/mailbox/compose_ticket_list.dart';
import 'package:hrm_app/data/model/mailbox/mailbox_user_mail_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_mailbox_repository/crm_mailbox_repository.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';

class ComposeProvider with ChangeNotifier {

  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  ComposeMailProjectList? composeMailProjectListResponse;
  ComposeMailTaskList? composeMailTaskListResponse;
  ComposeMailLeadList? composeMailLeadListResponse;
  ComposeMailInvoiceList? composeMailInvoiceListResponse;
  ComposeMailEstimateList? composeMailEstimateListResponse;
  ComposeMailProposalList? composeMailProposalListResponse;
  ComposeMailContractList? composeMailContractListResponse;
  ComposeMailTicketList? composeMailTicketListResponse;
  ComposeMailNoteList? composeMailNoteListResponse;
  ComposeMailProjectPaymentList? composeMailProjectPaymentListResponse;
  ComposeMailSalePaymentList? composeMailSalePaymentListResponse;


  MailBoxUserMailListModel? mailBoxUserMailListResponse;

  List<MailBoxUser> selectedRecipients = [];
  List<MailBoxUser> selectedCCList = [];


  ComposeProject? composeProject;
  ComposeTask? composeTask;
  ComposeLead? composeLead;
  ComposeInvoice? composeInvoice;
  ComposeEstimate? composeEstimate;
  ComposeProposal? composeProposal;
  ComposeContract? composeContract;
  ComposeTicket? composeTicket;
  ComposeNote? composeNote;
  ComposeProjectPayment? composeProjectPayment;
  ComposeSalePayment? composeSalePayment;


  String selectComposeType = 'Recipients';


  List<File> mailAttachmentImages = [];
  List<XFile> listOfFile = [];
  List<MultipartFile> mailAttachmentImageFiles = [];


  ComposeProvider(){
    getComposeProjectList();
    getComposeTaskList();
    getComposeLeadList();
    getComposeInvoiceList();
    getComposeEstimateList();
    getComposeProposalList();
    getComposeContractList();
    getComposeTicketList();
    getComposeNoteList();
    getComposeProjectPaymentList();
    getComposeSalePaymentList();
    getMailBoxUserMailList();
  }

  void setSelectedComposeType(String type) {
    selectComposeType = type;
    notifyListeners();
  }



  selectedComposeProject(ComposeProject composeProjectValue){
    composeProject = composeProjectValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeTask(ComposeTask composeTaskValue){
    composeTask = composeTaskValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeLead(ComposeLead composeLeadValue){
    composeLead = composeLeadValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeInvoice(ComposeInvoice composeInvoiceValue){
    composeInvoice = composeInvoiceValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeEstimate(ComposeEstimate composeEstimateValue){
    composeEstimate = composeEstimateValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeProposal(ComposeProposal composeProposalValue){
    composeProposal = composeProposalValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeContract(ComposeContract composeContractValue){
    composeContract = composeContractValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeTicket(ComposeTicket composeTicketValue){
    composeTicket = composeTicketValue;
    composeSalePayment = null;
    composeNote = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeNote(ComposeNote composeNoteValue){
    composeNote = composeNoteValue;
    composeSalePayment = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }


  selectedComposeProjectPayment(ComposeProjectPayment composeProjectPaymentValue){
    composeProjectPayment = composeProjectPaymentValue;
    composeSalePayment = null;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    notifyListeners();
  }


  selectedComposeSalePayment(ComposeSalePayment composeSalePaymentValue){
    composeSalePayment = composeSalePaymentValue;
    composeNote = null;
    composeTicket = null;
    composeContract = null;
    composeProposal = null;
    composeEstimate = null;
    composeInvoice = null;
    composeLead = null;
    composeTask = null;
    composeProject = null;
    composeProjectPayment = null;
    notifyListeners();
  }



  void toggleRecipients(MailBoxUser user) {
    if (selectedRecipients.any((element) => element.id == user.id)) {
      selectedRecipients.removeWhere((element) => element.id == user.id);
    } else {
      selectedRecipients.add(user);
    }
    notifyListeners();
  }



  void toggleCC(MailBoxUser user) {
    if (selectedCCList.any((element) => element.id == user.id)) {
      selectedCCList.removeWhere((element) => element.id == user.id);
    } else {
      selectedCCList.add(user);
    }
    notifyListeners();
  }



  getComposeProjectList() async {
    final response = await CrmMailboxRepository.getComposeProjectListData();
    if(response.result == true){
      composeMailProjectListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeTaskList() async {
    final response = await CrmMailboxRepository.getComposeTaskListData();
    if(response.result == true){
      composeMailTaskListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeLeadList() async {
    final response = await CrmMailboxRepository.getComposeLeadListData();
    if(response.result == true){
      composeMailLeadListResponse = response.data;
    }
    notifyListeners();
  }


  getComposeInvoiceList() async {
    final response = await CrmMailboxRepository.getComposeInvoiceListData();
    if(response.result == true){
      composeMailInvoiceListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeEstimateList() async {
    final response = await CrmMailboxRepository.getComposeEstimateListData();
    if(response.result == true){
      composeMailEstimateListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeProposalList() async {
    final response = await CrmMailboxRepository.getComposeProposalListData();
    if(response.result == true){
      composeMailProposalListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeContractList() async {
    final response = await CrmMailboxRepository.getComposeContractListData();
    if(response.result == true){
      composeMailContractListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeTicketList() async {
    final response = await CrmMailboxRepository.getComposeTicketListData();
    if(response.result == true){
      composeMailTicketListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeNoteList() async {
    final response = await CrmMailboxRepository.getComposeNoteListData();
    if(response.result == true){
      composeMailNoteListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeProjectPaymentList() async {
    final response = await CrmMailboxRepository.getComposeProjectPaymentListData();
    if(response.result == true){
      composeMailProjectPaymentListResponse = response.data;
    }
    notifyListeners();
  }



  getComposeSalePaymentList() async {
    final response = await CrmMailboxRepository.getComposeSalePaymentListData();
    if(response.result == true){
      composeMailSalePaymentListResponse = response.data;
    }
    notifyListeners();
  }



  getMailBoxUserMailList() async {
    final response = await CrmMailboxRepository.getMailboxUserMailListData();
    if(response.result == true){
      mailBoxUserMailListResponse = response.data;
    }
    notifyListeners();
  }



  Future postCompose(context) async {
    Map<String, MultipartFile> fileMap = {};
    for (int i = 0; i < listOfFile.length; i++) {
      var fileName = listOfFile[i].path.split('/').last;
      if (kDebugMode) {
        print(listOfFile[i]);
      }
      var mFile = await MultipartFile.fromFile(listOfFile[i].path, filename: fileName);
      fileMap["attachments[$i]"] = mFile;
    }

    final formData = FormData.fromMap({
      "subject" : subjectController.text,
      "message" : messageController.text,
      "source" : selectComposeType,
      "project_id" : composeProject?.id,
      "task_id" : composeTask?.id,
      "lead_id" : composeLead?.id,
      "ticket_id" : composeTicket?.id,
      "project_payment_id" : composeProjectPayment?.id,
      "sale_payment_id" : composeSalePayment?.id,
      "recipients[]" : selectedRecipients.isNotEmpty ? selectedRecipients.map((user) => user.email).toList() : null,
      "cc[]" : selectedCCList.isNotEmpty ? selectedCCList.map((user) => user.email).toList() : null,
    });

    formData.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));
    final response = await CrmMailboxRepository.postCompose(formData);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      // Provider.of<MailBoxProvider>(context, listen: false).getMailBoxList("");
      // Navigator.pop(context);
      NavUtil.navigateScreen(context, const ButtomNavigationBar());
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }  else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }
    notifyListeners();

  }




  Future<void> pickComposeAttachment(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            if (image != null) {
              mailAttachmentImages.add(File(image.path));
              listOfFile.add(image);
              notifyListeners();
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            if (imageGallery != null) {
              mailAttachmentImages.add(File(imageGallery.path));
              listOfFile.add(imageGallery);
              notifyListeners();
            }
          },
        );
      },
    );
  }

  void removeImage(int index) {
    mailAttachmentImages.removeAt(index);
    notifyListeners();
  }


}
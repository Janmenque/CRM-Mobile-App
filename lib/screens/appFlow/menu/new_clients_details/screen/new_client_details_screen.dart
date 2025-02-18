import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_contact_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_contract_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_estimate_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_expense.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_file_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_invoice_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_note_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_payment_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_profile_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_project_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_proposal_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_reminder_list.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/content/client_task_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_contact_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_contract_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_estimate_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_expense_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_file_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_note_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_payment_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_profile_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_project_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_proposal_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_reminder_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_task_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_invoice_list_provider.dart';
import 'package:provider/provider.dart';


class NewClientDetailsScreen extends StatelessWidget {
  final int clientId;
  const NewClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientContactProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientProfileProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientNoteProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientContractProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientFileProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientReminderProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientProjectProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientTaskProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientInvoiceListProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientProposalListProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientPaymentListProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientExpenseProvider(clientId)),
        ChangeNotifierProvider(create: (_) => ClientEstimateListProvider(clientId)),
      ],
      child: DefaultTabController(
        length: 13,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Client Details"),
            bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                    labelPadding: EdgeInsets.only(left: 0, right: 20),
                    isScrollable: true,
                    tabs: [
                      Text("Profile"),
                      Text("Contacts"),
                      Text("Notes"),
                      Text("Contracts"),
                      Text("Projects"),
                      Text("Tasks"),
                      Text("Invoices"),
                      Text("Payments"),
                      Text("Proposals"),
                      Text("Estimates"),
                      Text("Expenses"),
                      Text("Files"),
                      Text("Reminders"),
                    ]),
              ),
            ),
          ),
         body: TabBarView(
            children: [
              ClientProfileDetailsScreen(clientId: clientId),
              ClientContactListScreen(clientId: clientId),
              ClientNoteListScreen(clientId: clientId),
              ClientContractListScreen(clientId: clientId),
              ClientProjectListScreen(clientId: clientId),
              ClientTaskListScreen(clientId: clientId),
              ClientInvoiceListScreen(clientId: clientId),
              ClientPaymentListScreen(clientId: clientId),
              ClientProposalListScreen(clientId: clientId),
              ClientEstimateListScreen(clientId: clientId),
              ClientExpenseScreen(clientId: clientId),
              ClientFileListScreen(clientId: clientId),
              ClientReminderList(clientId: clientId),
          ]),
        ),
      ),
    );
  }
}

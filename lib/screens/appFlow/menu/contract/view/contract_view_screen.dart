import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_attachment_list_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_commen_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_item_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_note_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_renewal_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_template_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_attachment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_comment_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_item_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_note_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_renewal_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_template_provider.dart';
import 'package:provider/provider.dart';

class ContractViewScreen extends StatelessWidget {
  int contractId;
  ContractViewScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContractItemProvider(contractId)),
        ChangeNotifierProvider(create: (_) => ContractAttachmentProvider(contractId)),
        ChangeNotifierProvider(create: (_) => ContractCommentProvider(contractId)),
        ChangeNotifierProvider(create: (_) => ContractRenewalProvider(contractId)),
        ChangeNotifierProvider(create: (_) => ContractNoteProvider(contractId)),
        ChangeNotifierProvider(create: (_) => ContractTemplateProvider(contractId)),
      ],
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Contracts"),
            bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 24),
              child: TabBar(
                  isScrollable: true,
                  tabs: [
                    Text("Items"),
                    Text("Attachment"),
                    Text("Comments"),
                    Text("Renewal History"),
                    Text("Notes"),
                    Text("Templates"),
                  ]),
            ),
          ),
          body: TabBarView(
              children: [
                ContractItemListScreen(contractId: contractId,),
                ContractAttachmentListScreen(contractId: contractId,),
                ContractCommentList(contractId: contractId,),
                ContractRenewalList(contractId: contractId,),
                ContractNoteList(contractId: contractId),
                ContractTemplateList(contractId: contractId,)
              ]
          ),
        ),
      ),
    );
  }
}

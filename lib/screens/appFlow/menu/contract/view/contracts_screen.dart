import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/content/contract_type_list.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_list_provider.dart';
import 'package:provider/provider.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractListProvider>(
      builder: (context, provider, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Contracts", style: TextStyle(fontWeight: FontWeight.bold),),
              bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 24),
                child: TabBar(
                    isScrollable: false,
                    tabs: [
                      Text("Contract List"),
                      Text("Contract Type"),
                    ]),
              ),
            ),
            body: TabBarView(
                children: [
                  ContractList(contracts: provider.contractListResponse?.data?.data,),
                  const ContractTypeList(),
                ]
            ),
          ),
        );
      }
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_financial.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/financial_tab/edit_financial_tab/edit_financial_tab_provider.dart';
import 'package:provider/provider.dart';

class EditFinancialTab extends StatelessWidget {
  final ResponseFinancial? financialInfo;

  const EditFinancialTab({Key? key, this.financialInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditFinancialTabProvider(financialInfo),
      child: Consumer<EditFinancialTabProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                tr("financial_info_edit"),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      tr("tin"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.tinTextController,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        contentPadding:
                            const  EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_tin"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border:const  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("bank_name"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.bankNameTextController,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_bank_name"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      tr("bank_account"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.bankAccountNoTextController,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        contentPadding:
                           const  EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_bank_account"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updateFinancialInfo(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child:  Text(tr("save"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

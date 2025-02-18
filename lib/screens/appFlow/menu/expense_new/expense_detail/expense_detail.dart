import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/expense_new/expense_detail/expense_detail_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ExpenseDetail extends StatelessWidget {
  final int? expenseId;
  const ExpenseDetail({Key? key,this.expenseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseDetailProvider(expenseId),
      child: Consumer<ExpenseDetailProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
                elevation: 4,
                backgroundColor: AppColors.colorPrimary,
                title: const Text('Expense Details')),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Requested Amount",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(
                          provider.responseExpenseDetail?.data?.requestedAmount ?? "",
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Approved Amount",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(provider
                                .responseExpenseDetail?.data?.approvedAmount ??
                            ""),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Date Show",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(
                          provider.responseExpenseDetail?.data?.dateShow ?? "",
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(
                          provider.responseExpenseDetail?.data?.payment ?? "",
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(
                          provider.responseExpenseDetail?.data?.status ?? "",
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Reason",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Text(
                          provider.responseExpenseDetail?.data?.reason ?? '',
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

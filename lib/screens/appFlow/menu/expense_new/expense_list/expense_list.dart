import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';
import '../expense_category/expense_category.dart';
import '../expense_detail/expense_detail.dart';
import 'expense_list_provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseItemProvider(context),
      child: Consumer<ExpenseItemProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Expense"),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    NavUtil.navigateScreen(context, const ExpanseCategory());
                  },
                )
              ],
            ),
            body: Column(
              children: [
                InkWell(
                  onTap: () {
                    provider.selectDate(context);
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            provider.selectDate(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.angleLeft,
                            size: 30,
                            color: AppColors.colorPrimary,
                          )),
                      const Spacer(),
                      Center(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: AppColors.colorPrimary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            tr("Select Date"),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            provider.selectDate(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 30,
                            color: AppColors.colorPrimary,
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              tr("Select Payment"),
                              style: const TextStyle(fontSize: 14),
                            ),
                            value: provider.paymentTypeValue,
                            icon: const Icon(
                              Icons.arrow_downward,
                              size: 20,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              provider.paymentTypeMenu(newValue, context);
                            },
                            items: ["Paid", "Unpaid"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              tr("Expanse Status"),
                              style: const TextStyle(fontSize: 14),
                            ),
                            value: provider.expenseStatus,
                            icon: const Icon(
                              Icons.arrow_downward,
                              size: 20,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              provider.expenseStatusMenu(newValue, context);
                            },
                            items: ["Pending", "Approved", "Rejected"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.expenseList?.length ?? 0,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          NavUtil.navigateScreen(
                              context,
                              ExpenseDetail(
                                expenseId: provider.expenseList?[i].id,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: ListTile(
                                title: Text(
                                  provider.expenseList?[i].category ?? "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(
                                                int.parse("0xFFffFD815B")),
                                            style: BorderStyle.solid,
                                            width: 3.0,
                                          ),
                                          color:
                                              Color(int.parse("0xFFffFD815B")),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: DottedBorder(
                                          color: Colors.white,
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          strokeWidth: 1,
                                          child: const Text(
                                            "Pending",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(
                                                int.parse("0xFFffFD815B")),
                                            style: BorderStyle.solid,
                                            width: 3.0,
                                          ),
                                          color:
                                              Color(int.parse("0xFFffFD815B")),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: DottedBorder(
                                          color: Colors.white,
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          strokeWidth: 1,
                                          child: const Text(
                                            "unpaid",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Text(
                                    provider.expenseList?[i].dateShow ?? ""),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/expense_model/expense_category_model.dart';
import 'package:provider/provider.dart';
import '../../../../../custom_widgets/custom_dialog.dart';
import '../expense_create/expense_create.dart';
import 'expense_category_provider.dart';

class ExpanseCategory extends StatefulWidget {
  const ExpanseCategory({Key? key}) : super(key: key);

  @override
  State<ExpanseCategory> createState() => _ExpanseCategoryState();
}

class _ExpanseCategoryState extends State<ExpanseCategory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseCategoryProvider(),
        child: Consumer<ExpenseCategoryProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  tr("expense_log"),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("select_type_of_expense"),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    provider.isLoading == false
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: provider
                                  .expenseCategory?.data?.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider
                                    .expenseCategory?.data?.categories?[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Card(
                                    elevation: 4,
                                    child: RadioListTile<Category?>(
                                      title: Text(data?.name ?? ''),
                                      value: data,
                                      groupValue: provider.selectCategoryData,
                                      onChanged: (Category? value) {
                                        provider.selectCategory(value!);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Spacer(),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (provider.selectCategoryData?.id != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ExpenseCreate(
                                          categoryId:
                                              provider.selectCategoryData?.id,
                                          categoryName:
                                              provider.selectCategoryData?.name,
                                        )));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogError(
                                    title: tr("select_category"),
                                    subTitle:
                                        tr("you_must_be_select_a_category"),
                                  );
                                });
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: Text(tr("next"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

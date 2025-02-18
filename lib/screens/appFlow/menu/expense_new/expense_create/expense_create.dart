import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/expense_new/expense_create/expense_create_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/res.dart';

class ExpenseCreate extends StatelessWidget {
  final int? categoryId;
  final String? categoryName;
  const ExpenseCreate({Key? key,this.categoryId,this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(create: (context) => ExpenseCreateProvider(categoryId),
    child: Consumer<ExpenseCreateProvider>(
      builder: (context,provider,_){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              tr("Create Expanse"),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  color: Colors.blue[50],
                  child: ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.list_alt),
                    trailing:  Text(
                      tr("change"),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    title: Text(categoryName ?? ''),
                  ),
                ),
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
                              const Icon(Icons.date_range,color: AppColors.colorPrimary,),
                              const SizedBox(width: 10,),
                              Text(
                                provider.expenseDate != null
                                    ? "${provider.expenseDate!.toLocal()}".split(" ")[0]
                                    : tr("Select Expense Date"),
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
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("amount"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: provider.amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Enter Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("this_field_is_required");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Reference",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: provider.referenceController,
                        maxLines: 2,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Enter reference",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("this_field_is_required");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: provider.descriptionController,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Enter Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("this_field_is_required");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        tr("attachment"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.0,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () => provider.pickAttachmentImage(context),
                          child: DottedBorder(
                            color: const Color(0xffC7C7C7),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            strokeWidth: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Icon(
                                  Icons.upload_file,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  tr("upload_your_file"),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      provider.attachmentPath != null
                          ? Image.file(
                        provider.attachmentPath!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await provider.createExpanse(context);
                            }
                          },
                          style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child:  Text(tr("next"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),);
  }
}

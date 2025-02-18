import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/mailbox/mailbox_user_mail_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/compose_provider.dart';

class MailboxMultiselectCC extends StatelessWidget {
  ComposeProvider provider;
  MailboxMultiselectCC({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              showCategoryMultiSelectDialog(context, provider.mailBoxUserMailListResponse?.data ?? [], provider);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select CC',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox( height: 6,),
        provider.selectedRecipients.isNotEmpty ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Selected CC:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ) : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            provider.selectedCCList.map((e) => e.email).join(", "),
          ),
        ),
      ],
    );
  }

  void showCategoryMultiSelectDialog(BuildContext context, List<MailBoxUser> items, ComposeProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select CC") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((user) {
                    return CheckboxListTile(
                      title: Text(user.email!),
                      value: provider.selectedCCList.any((selected) => selected.id == user.id),
                      onChanged: (bool? value) {
                        provider.toggleCC(user);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

}

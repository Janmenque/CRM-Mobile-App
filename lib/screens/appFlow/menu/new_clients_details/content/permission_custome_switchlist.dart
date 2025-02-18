import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_contact_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_switch_row.dart';

class PermissionCustomSwitchList extends StatelessWidget {
  ClientContactProvider? provider;
  PermissionCustomSwitchList({
    super.key, this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18,),
          const Text("Permissions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          CustomSwitchRow(
            label: "Invoices",
            value: provider?.invoice ?? false,
            onChanged: (value) {
              provider?.inVoiceSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Projects",
            value: provider?.project ?? false, // Example: Different value
            onChanged: (value) {
              provider?.projectSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Contract",
            value: provider?.contract ?? false,
            onChanged: (value) {
              provider?.contractSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "ticket",
            value: provider?.ticket ?? false, // Example: Different value
            onChanged: (value) {
              provider?.ticketSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "File",
            value: provider?.file ?? false,
            onChanged: (value) {
              provider?.fileSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Contact",
            value: provider?.contact ?? false, // Example: Different value
            onChanged: (value) {
              provider?.contactSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Estimates",
            value: provider?.estimate ?? false,
            onChanged: (value) {
              provider?.estimateSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Task",
            value: provider?.task ?? false, // Example: Different value
            onChanged: (value) {
              provider?.taskSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Proposal",
            value: provider?.proposal ?? false,
            onChanged: (value) {
              provider?.proposalSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Note",
            value: provider?.note ?? false, // Example: Different value
            onChanged: (value) {
              provider?.noteSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Reminder",
            value: provider?.reminder ?? false,
            onChanged: (value) {
              provider?.reminderSwitch(value);
            },
          ),
        ],
      ),
    );
  }
}
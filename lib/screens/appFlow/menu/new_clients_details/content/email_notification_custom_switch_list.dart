import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_contact_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_switch_row.dart';

class EmailNotificationsCustomSwitchList extends StatelessWidget {
  ClientContactProvider? provider;
  EmailNotificationsCustomSwitchList({
    super.key, this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14,),
          const Text("Email Notifications", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8,),
          CustomSwitchRow(
            label: "Invoices",
            value: provider?.emailInvoice ?? false,
            onChanged: (value) {
              provider?.emailInvoiceSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Projects",
            value: provider?.emailProject ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailProjectSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Contract",
            value: provider?.emailContract ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailContractSwitch(value);
            },
          ),

          const Divider(),
          CustomSwitchRow(
            label: "Ticket",
            value: provider?.emailTicket ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailTicketSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Estimate",
            value: provider?.emailEstimate ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailEstimateSwitch(value);
            },
          ),

          const Divider(),
          CustomSwitchRow(
            label: "Task",
            value: provider?.emailTask ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailTaskSwitch(value);
            },
          ),
          const Divider(),
          CustomSwitchRow(
            label: "Proposal",
            value: provider?.emailProposal ?? false, // Example: Different value
            onChanged: (value) {
              provider?.emailProposalSwitch(value);
            },
          ),
        ],
      ),
    );
  }
}
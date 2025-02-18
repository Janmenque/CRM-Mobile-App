import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/compose_provider.dart';

class ComposeTypeHorizontalList extends StatelessWidget {
  ComposeProvider provider;
  ComposeTypeHorizontalList({
    super.key, required this.provider
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'project',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Project'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'task',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Task'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'lead',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Lead'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'invoice',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Invoice'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'estimate',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Estimate'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'proposal',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child:const Text('Proposal'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'contract',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Contract'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'ticket',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Ticket'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'note',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Note'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'project_Payment',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Project Payment'),
          ),
          Transform.scale(
            scale: 0.8,
            child: Radio<String>(
              value: 'sale_payment',
              groupValue: provider.selectComposeType,
              onChanged: (value) {
                provider.setSelectedComposeType(value!);
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, 0), // Adjust offset as needed
            child: const Text('Sale Payment'),
          ),
        ],
      ),
    );
  }
}
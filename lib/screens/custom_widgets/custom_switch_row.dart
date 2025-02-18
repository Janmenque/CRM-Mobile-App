import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class CustomSwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            activeColor: AppColors.colorPrimary,
            onChanged: onChanged,
            inactiveThumbColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}

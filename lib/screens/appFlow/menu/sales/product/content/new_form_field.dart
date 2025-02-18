import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  const   NewTextField({
    super.key, this.labelText, this.maxLine, this.formHeight, this.controller, this.textInputTypeField, this.readOnly = false,
  });
  final String? labelText;
  final int? maxLine;
  final double? formHeight;
  final TextEditingController? controller;
  final TextInputType? textInputTypeField;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: TextField(
          keyboardType: TextInputType.text ?? textInputTypeField,
          controller: controller,
          cursorHeight: 18,
          readOnly: readOnly,
          maxLines: maxLine ??  1,
          decoration: InputDecoration(
            hintText : labelText ?? "",
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
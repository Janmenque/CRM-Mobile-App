import 'package:flutter/material.dart';

Container buildProfileDetails({String? title, String? description}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text("$title"),
            )),
        Expanded(flex: 2, child: Text("$description")),
      ],
    ),
  );
}

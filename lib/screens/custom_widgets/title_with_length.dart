import 'package:flutter/material.dart';

class TitleAndLength extends StatelessWidget {
  const TitleAndLength({
    super.key, this.title, this.length
  });

  final String? title;
  final int? length;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          Text("Total : ${length ?? ""}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }
}
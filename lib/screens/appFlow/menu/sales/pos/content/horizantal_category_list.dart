import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Text("Category", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),),
        ),
        const SizedBox(width: 8,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Text("Brand", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),),
        ),
        const SizedBox(width: 8,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Text("Feature", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}
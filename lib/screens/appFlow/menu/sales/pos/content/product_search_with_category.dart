import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/content/horizantal_category_list.dart';

class ProductSearchWithCategory extends StatelessWidget {
  const ProductSearchWithCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height:  48,
          child: TextField(
            cursorHeight: 18,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey,),
              labelText: 'Search product by name / code',
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12,),
        const CategoryList(),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/home/widgets/home_categories.dart';

class CategoryButton extends StatelessWidget {
  final int index;

  CategoryButton({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          categories[index],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

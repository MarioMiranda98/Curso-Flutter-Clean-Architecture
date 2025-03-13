import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/home/widgets/item_card.dart';
import 'package:flutter_clean_architecture/test_interface_products.dart';

class HomeProducts extends StatelessWidget {
  HomeProducts();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
          ),
          itemCount: testProductInterface.length,
          itemBuilder: (context, index) {
            return ItemCard(
              onTap: () {},
              productEntity: testProductInterface.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}

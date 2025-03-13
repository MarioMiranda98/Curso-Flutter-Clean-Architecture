import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';

class ItemCard extends StatelessWidget {
  final void Function() onTap;
  final ProductEntity productEntity;

  ItemCard({
    required this.onTap,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Hero(
                tag: '${productEntity.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(productEntity.image),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

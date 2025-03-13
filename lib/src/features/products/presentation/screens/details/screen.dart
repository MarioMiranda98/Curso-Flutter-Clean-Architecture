import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/details/components/body.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/widgets/app_bar.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  ProductEntity product;

  DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
      appBar: productAppBar(context),
      body: BodyDetail(
        product: product,
      ),
    );
  }
}

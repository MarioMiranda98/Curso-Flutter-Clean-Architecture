import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/providers/product_provider.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/home/widgets/item_card.dart';

class HomeProducts extends StatefulWidget {
  HomeProducts();

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  late Future<dartz.Either<String, List<ProductEntity>>> _future;

  @override
  void initState() {
    ProductProvider productProvider = context.call();

    _future = productProvider.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        dartz.Either<String, List<ProductEntity>> eitherProducts =
            snapshot.data!;

        return eitherProducts.fold((l) => Text(l), (products) {
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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final ProductEntity productEntity = products.elementAt(index);

                  return ItemCard(
                    onTap: () {},
                    productEntity: productEntity,
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }
}

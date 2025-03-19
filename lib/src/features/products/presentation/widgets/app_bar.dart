import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/providers/product_provider.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/details/screen.dart';

AppBar productAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () =>
              showSearch(context: context, delegate: CustomSearch()),
          icon: const Icon(Icons.search)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
    ],
  );
}

class CustomSearch extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider productProvider = context.read();

    return FutureBuilder(
      future: productProvider.getProduct(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return const Center(
            child: Text("Producto inexistente"),
          );
        }

        Either<String, ProductEntity> eitherProduct = snapshot.data!;

        return eitherProduct.fold(
          (l) => Center(
            child: Text(l),
          ),
          (product) => InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsScreen(product: product),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(product.title))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}

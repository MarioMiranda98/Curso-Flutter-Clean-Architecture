import 'package:flutter/material.dart';

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}

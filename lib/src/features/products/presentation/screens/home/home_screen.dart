import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/home/widgets/home_categories.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: productAppBar(context),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeCategories(),
        ],
      ),
    );
  }
}

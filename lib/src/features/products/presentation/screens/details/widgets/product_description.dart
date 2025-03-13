import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDescription extends StatelessWidget {
  String description;

  ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(description),
    );
  }
}

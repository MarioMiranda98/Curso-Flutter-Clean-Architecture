import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/details/widgets/details_addtocart.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/details/widgets/details_counter_fav.dart';

import '../widgets/image_product_and_title.dart';
import '../widgets/product_description.dart';

// ignore: must_be_immutable
class BodyDetail extends StatefulWidget {
  ProductEntity product;

  BodyDetail({super.key, required this.product});

  @override
  State<BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          _bottomBox(size),
          ImageProductAndTitle(product: widget.product)
        ],
      ),
    );
  }

  Container _bottomBox(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.32),
      padding: EdgeInsets.only(top: size.height * 0.15, left: 20, right: 20),
      height: 550.0,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        children: [
          ProductDescription(
            description: widget.product.description,
          ),
          const SizedBox(
            height: 10,
          ),
          DetailsCounterFav(
            quantity: quantity,
            decreasing: (newQuantity) {
              quantity = newQuantity;
              setState(() {});
            },
            increasing: (newQuantity) {
              quantity = newQuantity;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const DetailsAddtocart()
        ],
      ),
    );
  }
}

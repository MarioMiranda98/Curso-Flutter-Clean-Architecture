import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ImageProductAndTitle extends StatelessWidget {
  ProductEntity product;

  ImageProductAndTitle({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Price\n",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: "\$${product.price}",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20))
              ])),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Hero(
                tag: "${product.id}",
                child: SizedBox(
                  height: size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsCounterFav extends StatelessWidget {
  int quantity;
  Function(int quantity) decreasing;
  Function(int quantity) increasing;

  DetailsCounterFav(
      {super.key,
      required this.quantity,
      required this.decreasing,
      required this.increasing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Counter
        Row(
          children: [
            IconButton(
                onPressed: () {
                  // Disminuir la cantidad en 1
                  final newQuantity = quantity - 1;
                  decreasing(newQuantity);
                },
                icon: const Icon(
                  Icons.remove,
                  size: 40,
                )),
            Text(
              "$quantity",
              style: const TextStyle(fontSize: 25),
            ),
            IconButton(
                onPressed: () {
                  // Aumentar la cantidad en 1
                  final newQuantity = quantity + 1;
                  increasing(newQuantity);
                },
                icon: const Icon(
                  Icons.add,
                  size: 40,
                )),
          ],
        ),

        /// Favorite
        Container(
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: IconButton(
                color: Colors.black,
                onPressed: () {},
                icon: const Icon(Icons.favorite)))
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DetailsAddtocart extends StatelessWidget {
  const DetailsAddtocart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: InkWell(
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey),
                child: const Center(
                    child: Text(
                  "Buy now",
                  textAlign: TextAlign.center,
                ))),
          ))
        ],
      ),
    );
  }
}

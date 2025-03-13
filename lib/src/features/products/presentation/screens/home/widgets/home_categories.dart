import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/src/features/products/presentation/screens/home/widgets/category_button.dart';

final List categories = [
  "Electronics",
  "Jewelry",
  "Men´s clothing",
  "Women's clothing",
];

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 30.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryButton(index: index);
            }),
      ),
    );
  }
}

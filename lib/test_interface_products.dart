import 'package:flutter_clean_architecture/src/features/products/domain/entities/product_entity.dart';
import 'package:flutter_clean_architecture/src/features/products/domain/entities/rating_entity.dart';

final testProductEntity = ProductEntity(
  id: 9,
  title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
  price: 64.0,
  description:
      "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
  category: "electronics",
  image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
  rating: RatingEntity(
    rate: 3.3,
    count: 203,
  ),
);

List<ProductEntity> testProductInterface = [
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
  testProductEntity,
];

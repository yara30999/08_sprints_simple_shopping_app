import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class ProductsPageView extends StatelessWidget {
  const ProductsPageView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              products[index].image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

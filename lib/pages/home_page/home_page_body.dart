import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import 'widgets/offers_horiz_list_view.dart';
import 'widgets/products_grid_view.dart';
import 'widgets/products_page_view.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody({
    super.key,
  });

  // Sample data for products
  final List<Product> products = [
    Product(name: 'Product 1', image: 'assets/png/offer_07.png'),
    Product(name: 'Product 2', image: 'assets/png/product_02.png'),
    Product(name: 'Product 3', image: 'assets/png/product_03.png'),
    Product(name: 'Product 4', image: 'assets/png/product_04.png'),
    Product(name: 'Product 5', image: 'assets/png/product_05.png'),
    Product(name: 'Product 6', image: 'assets/png/product_06.png'),
    Product(name: 'Product 7', image: 'assets/png/product_07.png'),
    Product(name: 'Product 8', image: 'assets/png/offer_05.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            'Our Products',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ProductsPageView(products: products),
          ProductsGridView(products: products),
          Text(
            'Hot Offers',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          HotOffersHorizontalListView(),
        ],
      ),
    );
  }
}

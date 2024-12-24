import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import 'offers_card.dart';

class HotOffersHorizontalListView extends StatelessWidget {
  HotOffersHorizontalListView({
    super.key,
  });

  final List<Product> hotOffers = [
    Product(name: 'offer 1', image: 'assets/png/offer_01.png'),
    Product(name: 'offer 2', image: 'assets/png/offer_02.png'),
    Product(name: 'offer 3', image: 'assets/png/offer_03.png'),
    Product(name: 'offer 4', image: 'assets/png/offer_04.png'),
    Product(name: 'offer 5', image: 'assets/png/offer_05.png'),
    Product(name: 'offer 6', image: 'assets/png/offer_06.png'),
    Product(name: 'offer 7', image: 'assets/png/offer_07.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotOffers.length,
        itemBuilder: (context, index) {
          return OffersCard(hotOffer: hotOffers[index]);
        },
      ),
    );
  }
}

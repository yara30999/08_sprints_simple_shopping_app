import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({
    super.key,
    required this.hotOffer,
  });

  final Product hotOffer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                hotOffer.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(hotOffer.name),
            ),
          ],
        ),
      ),
    );
  }
}

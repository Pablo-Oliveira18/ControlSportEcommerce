import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile(this.product);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.images.first),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                // apartir de text
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'A partir de',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

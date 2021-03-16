import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_product.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  //

  const CartTile(this.cartProduct);
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(cartProduct.product.images.first),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Text(
                          cartProduct.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Tamanho; ${cartProduct.size}',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Text(
                          'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
              child: Text('data'),
            )
          ],
        ),
      ),
    );
  }
}

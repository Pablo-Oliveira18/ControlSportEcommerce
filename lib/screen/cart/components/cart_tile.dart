import 'package:controlsport_app_ecommerce/common/custom_icon_button.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  //

  const CartTile(this.cartProduct);
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
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
              Divider(
                color: Colors.amber,
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return Row(
                    children: [
                      CustomIconButton(
                        iconData: Icons.remove,
                        color: Theme.of(context).primaryColor,
                        onTap: cartProduct.decrement,
                      ),
                      Container(
                        color: Colors.grey.withAlpha(100),
                        width: 30,
                        child: Center(
                          child: Text(
                            '${cartProduct.quantity}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      CustomIconButton(
                        iconData: Icons.add,
                        color: Theme.of(context).primaryColor,
                        onTap: cartProduct.increment,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

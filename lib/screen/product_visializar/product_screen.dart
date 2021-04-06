import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/screen/product_visializar/components/size_widger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                          arguments: product);
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: product.images.map(
                    (url) {
                      return NetworkImage(url);
                    },
                  ).toList(),
                  dotSize: 5,
                  dotBgColor: Colors.grey[1000],
                  dotColor: primaryColor,
                  autoplay: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  textTitle(titulo: product.name, sizes: 20, top: 1),
                  subTitle(sub: 'Desrição'),
                  textTitle(titulo: product.description),
                  subTitle(sub: 'Marca'),
                  textTitle(
                      titulo: product.brandy != null
                          ? product.brandy
                          : 'Control Sport\'s'),
                  // subTitle(sub: 'Preço', sizes: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Valor',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(3),
                    child: subTitle(
                        sub: 'R\$ ${product.basePrice.toStringAsFixed(2)}',
                        bold: FontWeight.bold,
                        color: primaryColor,
                        sizes: 20),
                  ),
                  subTitle(sub: 'Tamanhos'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 10,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                  ),
                  subTitle(
                    sub:
                        'Todos os tamanhos disponiveis se encontra na cor cinza, e os não disponiveis na cor vermelha.',
                    color: Colors.grey,
                    sizes: 10,
                  ),
                  const SizedBox(height: 20),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: product.selectedSize != null
                                ? () {
                                    if (userManager.isLoggedIn) {
                                      context
                                          .read<CartManager>()
                                          .addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para comprar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textTitle(
      {String titulo,
      double sizes,
      Color color,
      FontWeight bold,
      double top,
      double bottom}) {
    return Padding(
      padding: EdgeInsets.only(
          top: top != null ? top : 10, bottom: bottom != null ? bottom : 8),
      child: Text(
        titulo,
        style: TextStyle(
          color: color != null ? color : Colors.black,
          fontSize: sizes != null ? sizes : 15,
          fontWeight: bold != null ? bold : null,
        ),
      ),
    );
  }

  Widget subTitle({String sub, double sizes, FontWeight bold, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        sub,
        style: TextStyle(
          color: color != null ? color : Colors.black,
          fontSize: sizes != null ? sizes : 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

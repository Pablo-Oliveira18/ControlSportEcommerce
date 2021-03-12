import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textTitle(titulo: product.name, sizes: 20, top: 1),
                subTitle(sub: 'A partir de', sizes: 12),
                subTitle(
                    sub: 'R\$ 20,99',
                    bold: FontWeight.bold,
                    color: primaryColor,
                    sizes: 20),
                subTitle(sub: 'Desrição'),
                textTitle(titulo: product.description),
                subTitle(sub: 'Marca'),
              ],
            ),
          )
        ],
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

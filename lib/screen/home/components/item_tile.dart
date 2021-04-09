import 'dart:io';

import 'package:controlsport_app_ecommerce/models/home/home_manager.dart';
import 'package:controlsport_app_ecommerce/models/products/product_manager.dart';
import 'package:controlsport_app_ecommerce/models/section/section.dart';
import 'package:controlsport_app_ecommerce/models/section/section_item.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Editar Item'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            context.read<Section>().removeItem(item);
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.red,
                          child: const Text('Excluir'),
                        ),
                      ],
                    );
                  });
            }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image as String,
                fit: BoxFit.cover,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
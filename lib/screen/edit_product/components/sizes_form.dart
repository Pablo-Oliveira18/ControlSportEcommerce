import 'package:controlsport_app_ecommerce/models/itemSize/item_size.dart';
import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/screen/edit_product/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state) {
        return Column(
          children: state.value.map((size) {
            return EditItemSize(size: size);
          }).toList(),
        );
      },
    );
  }
}

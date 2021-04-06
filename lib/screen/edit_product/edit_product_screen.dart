import 'package:controlsport_app_ecommerce/models/products/product.dart';
import 'package:controlsport_app_ecommerce/screen/edit_product/components/sizes_form.dart';
import 'package:flutter/material.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    validator: (name) {
                      if (name.length < 6) return 'Título muito curto';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: InputBorder.none),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 10) return 'Descrição muito curta';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Marca',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.brandy,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Marca', border: InputBorder.none),
                    maxLines: null,
                    validator: (marc) {
                      if (marc.isEmpty) return 'Marca não pode ser vazia';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Categoria',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.category,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Categoria', border: InputBorder.none),
                    maxLines: null,
                    validator: (category) {
                      if (category.isEmpty)
                        return 'Categoria não pode ser vazia';
                      return null;
                    },
                  ),
                  SizesForm(product),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print('válido!!!');
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

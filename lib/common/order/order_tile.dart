import 'package:controlsport_app_ecommerce/common/order/cancel_order_dialog.dart';
import 'package:controlsport_app_ecommerce/common/order/export_address_dilog.dart';
import 'package:controlsport_app_ecommerce/models/order/order.dart';
import 'package:controlsport_app_ecommerce/screen/order/common/order_product_tile.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 20),
                Center(child: Text("Endereço de Entrega")),
                Divider(height: 20),
                Text(
                    'Cidade: ${order.address.city}, Estado: ${order.address.state},'),
                SizedBox(height: 5),
                Text(
                    'Rua: ${order.address.street}, N: ${order.address.number}, '),
                SizedBox(height: 5),
                Text('Bairro: ${order.address.district}'),
                SizedBox(height: 5),
                Text('CEP: ${order.address.zipCode}'),
              ],
            ),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FlatButton(
                    onPressed: order.back,
                    child: const Text('Recuar'),
                  ),
                  FlatButton(
                    onPressed: order.advance,
                    child: const Text('Avançar'),
                  ),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => CancelOrderDialog(order));
                    },
                    textColor: Colors.red,
                    child: const Text('Cancelar'),
                  ),

                  // FlatButton(
                  //   onPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (_) => ExportAddressDialog(order.address));
                  //   },
                  //   textColor: primaryColor,
                  //   child: const Text('Endereço'),
                  // )
                ],
              ),
            )
        ],
      ),
    );
  }
}

import 'package:controlsport_app_ecommerce/common/cart/price_cart.dart';
import 'package:controlsport_app_ecommerce/models/cart(carrinho)/cart_manager.dart';
import 'package:controlsport_app_ecommerce/models/checkout/checkout_manager.dart';
import 'package:controlsport_app_ecommerce/screen/checkout/components/cpf_field.dart';
import 'package:controlsport_app_ecommerce/screen/checkout/components/dados_cartao.dart';
import 'package:controlsport_app_ecommerce/models/credit_card/credit_card.dart';
import 'package:controlsport_app_ecommerce/screen/checkout/components/installments.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'components/credit_card_widget.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CreditCard creditCard = CreditCard();

  int _group = 1;

  void installments(int value) {
    setState(() {
      _group = value;
      print(_group);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if (checkoutManager.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      )
                    ],
                  ),
                );
              }

              return Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    CreditCardWidget(
                      creditCard,
                    ),
                    // DadosCartao(),
                    InstallmentsWidget(),
                    CpfField(),
                    // Card(
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 8),
                    //   child: Column(
                    //     children: <Widget>[
                    //       ListTile(
                    //         title: Text(
                    //             "À vista R\$ ${cartManager.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}"),
                    //         leading: Radio(
                    //           value: 1,
                    //           groupValue: _group,
                    //           activeColor: Theme.of(context).primaryColor,
                    //           onChanged: (int value) => installments(value),
                    //         ),
                    //       ),
                    //       ListTile(
                    //         title: Text(
                    //             "2 x R\$ ${cartManager.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}"),
                    //         leading: Radio(
                    //           value: 2,
                    //           groupValue: _group,
                    //           activeColor: Theme.of(context).primaryColor,
                    //           onChanged: (int value) => installments(value),
                    //         ),
                    //       ),
                    //       ListTile(
                    //         title: Text(
                    //             "3 x R\$ ${cartManager.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}"),
                    //         leading: Radio(
                    //           value: 3,
                    //           groupValue: _group,
                    //           activeColor: Theme.of(context).primaryColor,
                    //           onChanged: (int value) => installments(value),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    PriceCard(
                      buttonText: 'Finalizar Pedido',
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();

                          checkoutManager.checkout(
                              installments: _group,
                              creditCard: creditCard,
                              onStockFail: (e) {
                                Navigator.of(context).popUntil(
                                    (route) => route.settings.name == '/cart');
                              },
                              onPayFail: (e) {
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSuccess: (order) {
                                Navigator.of(context).popUntil(
                                    (route) => route.settings.name == '/');
                                Navigator.of(context).pushNamed('/confirmation',
                                    arguments: order);
                              });
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

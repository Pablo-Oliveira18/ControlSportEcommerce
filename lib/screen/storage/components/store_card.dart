import 'package:controlsport_app_ecommerce/common/custom_icon_button.dart';
import 'package:controlsport_app_ecommerce/models/storage/store.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            color: Colors.yellow[100],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "NOSSA MISSÃO, VISÃO E VALORES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Divider(
                    height: 15,
                  ),
                  Text(
                      "Ser a melhor loja de moda masculina, com os melhores produtos, serviços e atendimento a seus clientes."),
                  SizedBox(height: 10),
                  Text(
                      "Buscar a satisfação total de nossos clientes, garantindo atendimento com excelência profissional e técnica, fornecendo os melhores produtos, aplicar preços justos."),
                  SizedBox(height: 10),
                  Text(
                      "Garantir que o atendimento aos nossos clientes, mesmo no site para compras eletrônicas, seja do mais alto padrão, oferecendo nosso contato por telefone, skype, chat ou e-mail, prestando todo e qualquer esclarecimento solicitado pelo cliente."),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: <Widget>[
              Divider(),
              Image.network(store.image),
              Container(
                height: 140,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            store.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            store.addressText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            store.openingText,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomIconButton(
                          iconData: Icons.location_on_outlined,
                          color: Colors.orange[400],
                          onTap: () {},
                        ),
                        CustomIconButton(
                          iconData: Icons.phone,
                          color: Colors.green,
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

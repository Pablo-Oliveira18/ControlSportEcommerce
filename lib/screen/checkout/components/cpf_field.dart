import 'package:brasil_fields/brasil_fields.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CpfField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final userManager = context.watch<UserManager>();
    //
    return Card(
      color: Colors.amber[100],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'CPF',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: userManager.usuario.cpf,
                decoration: InputDecoration(
                  labelText: 'CPF do Titular',
                  prefixIcon: Icon(Icons.credit_card),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (cpf) {
                  if (cpf.isEmpty)
                    return 'Campo Obrigatório';
                  else if (!CPFValidator.isValid(cpf)) return 'CPF Inválido';
                  return null;
                },
                onSaved: userManager.usuario.setCpf,
              ),
            ],
          )),
    );
  }
}

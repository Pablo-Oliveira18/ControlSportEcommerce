import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DadosCartao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    return Card(
      color: Colors.amber[100],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: const Text(
                  'Dados do Cartão',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Numero Cartão',
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

              SizedBox(height: 15),
              // nome
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome do Titular do Cartão',
                  prefixIcon: Icon(Icons.people),
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

              //
              SizedBox(height: 15),

              //
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'MM/YYYY',
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
                        else if (!CPFValidator.isValid(cpf))
                          return 'CPF Inválido';
                        return null;
                      },
                      onSaved: userManager.usuario.setCpf,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
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
                        else if (!CPFValidator.isValid(cpf))
                          return 'CPF Inválido';
                        return null;
                      },
                      onSaved: userManager.usuario.setCpf,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              TextFormField(
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

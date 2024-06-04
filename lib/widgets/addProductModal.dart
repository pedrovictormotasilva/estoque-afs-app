import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductModal extends StatefulWidget {
  final String accessToken;
  final int categoryId;

  const AddProductModal({Key? key, required this.accessToken, required this.categoryId}) : super(key: key);

  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  final _formKey = GlobalKey<FormState>();
  String _productName = '';
  String _productDescription = '';
  int _productStock = 0;

  Future<void> _createProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.parse('https://api-estoque-adolfo.vercel.app/Product');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
        body: json.encode({
          'nome': _productName,
          'descricao': _productDescription,
          'estoque': _productStock,
          'categoria_id': widget.categoryId,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pop(true);
      } else {
        final responseData = json.decode(response.body);
        print('Erro ao criar produto: ${responseData['message']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do Produto'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do produto';
                }
                return null;
              },
              onSaved: (value) {
                _productName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descrição'),
              onSaved: (value) {
                _productDescription = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Estoque'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return 'Por favor, insira uma quantidade válida';
                }
                return null;
              },
              onSaved: (value) {
                _productStock = int.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Adicionar'),
          onPressed: _createProduct,
        ),
      ],
    );
  }
}

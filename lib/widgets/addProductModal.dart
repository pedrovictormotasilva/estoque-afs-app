import 'package:estoque_app/utils/crud_route.dart';
import 'package:flutter/material.dart';

class AddProductModal extends StatefulWidget {
  final String accessToken;

  const AddProductModal({Key? key, required this.accessToken})
      : super(key: key);

  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        final newProduct = {
          'nome': _nameController.text,
          'estoque': int.tryParse(_stockController.text) ?? 0,
          'categoryId': int.tryParse(_categoryIdController.text) ?? 0,
        };

        await ProductApiService.createProduct(widget.accessToken, newProduct);
        Navigator.of(context).pop(true); // Retornar true para indicar sucesso
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao criar produto: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Produto'),
      content: _isLoading
          ? CircularProgressIndicator()
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _stockController,
                    decoration: InputDecoration(labelText: 'Estoque'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o estoque';
                      } else if (int.tryParse(value) == null) {
                        return 'Estoque deve ser um número';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _categoryIdController,
                    decoration: InputDecoration(labelText: 'ID da Categoria'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o ID da categoria';
                      } else if (int.tryParse(value) == null) {
                        return 'ID da Categoria deve ser um número';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _createProduct,
          child: Text('Criar'),
        ),
      ],
    );
  }
}

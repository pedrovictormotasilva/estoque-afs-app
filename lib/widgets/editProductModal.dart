import 'package:estoque_app/utils/crud_route.dart';
import 'package:flutter/material.dart';


class EditProductModal extends StatefulWidget {
  final String accessToken;
  final int productId;
  final String initialTitle;
  final String initialCode;
  final int initialStock;

  const EditProductModal({
    Key? key,
    required this.accessToken,
    required this.productId,
    required this.initialTitle,
    required this.initialCode,
    required this.initialStock,
  }) : super(key: key);

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  late TextEditingController _titleController;
  late TextEditingController _codeController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _codeController = TextEditingController(text: widget.initialCode);
    _stockController = TextEditingController(text: widget.initialStock.toString());
  }

  Future<void> _updateProduct() async {
    try {
      final updatedProduct = {
        'nome': _titleController.text,
        'codigo': _codeController.text,
        'estoque': int.parse(_stockController.text),
      };

      await ProductApiService.updateProduct(widget.accessToken, widget.productId, updatedProduct);
      Navigator.of(context).pop(); // Close the modal after updating
    } catch (error) {
      print('Erro ao atualizar o produto: $error');
      // Handle the error, e.g., show a snackbar with the error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Produto'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Estoque'),
              keyboardType: TextInputType.number,
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
        TextButton(
          child: Text('Salvar'),
          onPressed: _updateProduct,
        ),
      ],
    );
  }
}

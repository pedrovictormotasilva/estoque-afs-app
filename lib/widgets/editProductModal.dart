import 'package:flutter/material.dart';
import 'package:estoque_app/utils/crud_util.dart';

class EditProductModal extends StatefulWidget {
  final String accessToken;
  final int productId;
  final String productName;
  final String productCode;
  final int productStock;

  const EditProductModal({
    Key? key,
    required this.accessToken,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.productStock,
  }) : super(key: key);

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _stockController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productName);
    _codeController = TextEditingController(text: widget.productCode);
    _stockController = TextEditingController(text: widget.productStock.toString());
  }

  Future<void> _updateProduct() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updatedProduct = {
        'nome': _nameController.text,
        'codigo': _codeController.text,
        'estoque': int.parse(_stockController.text),
      };

      await ProductApiService.updateProduct(widget.accessToken, widget.productId, updatedProduct);
      Navigator.of(context).pop(true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao atualizar produto: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Produto'),
      content: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
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
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: _updateProduct,
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

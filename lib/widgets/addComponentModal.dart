import 'package:estoque_app/utils/component_api_util.dart';
import 'package:flutter/material.dart';


class AddComponentModal extends StatefulWidget {
  final String accessToken;

  const AddComponentModal({Key? key, required this.accessToken}) : super(key: key);

  @override
  _AddComponentModalState createState() => _AddComponentModalState();
}

class _AddComponentModalState extends State<AddComponentModal> {
  final _formKey = GlobalKey<FormState>();
  String _componentName = '';

  Future<void> _createComponent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await ComponentApiService.createComponent(widget.accessToken, _componentName);
        Navigator.of(context).pop(true);
      } catch (e) {
        print('Error creating component: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Componente'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Nome do Componente'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o nome do componente';
            }
            return null;
          },
          onSaved: (value) {
            _componentName = value!;
          },
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
          onPressed: _createComponent,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';


class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _price = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  // Aceita "12,50" e "12.50"
  double? _parsePrice(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop((
      name: _name.text.trim(),
      price: _parsePrice(_price.text)!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo produto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'O nome é obrigatório'
                  : null,
            ),
            TextFormField(
              controller: _price,
              decoration: const InputDecoration(labelText: 'Preço (€)'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                final price = _parsePrice(value);
                if (price == null) return 'Preço inválido';
                if (price < 0) return 'O preço não pode ser negativo';
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}
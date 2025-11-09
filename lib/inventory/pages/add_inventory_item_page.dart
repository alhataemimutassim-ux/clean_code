import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_example/inventory/state/inventory_provider.dart';
import 'package:clean_architecture_example/inventory/models/inventory_item.dart';

class AddInventoryItemPage extends StatefulWidget {
  const AddInventoryItemPage({super.key});

  @override
  State<AddInventoryItemPage> createState() => _AddInventoryItemPageState();
}

class _AddInventoryItemPageState extends State<AddInventoryItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController(text: '1');
  final _locationCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<InventoryProvider>();
    final item = InventoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      quantity: int.tryParse(_quantityCtrl.text) ?? 1,
      location: _locationCtrl.text.trim().isEmpty
          ? 'Unknown'
          : _locationCtrl.text.trim(),
    );
    provider.addItem(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Inventory Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 0) return 'Enter a valid quantity';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationCtrl,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_example/inventory/state/inventory_provider.dart';
import 'package:clean_architecture_example/inventory/models/inventory_item.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();
    final items = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse Manager'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items in inventory'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final InventoryItem item = items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Location: ${item.location}'),
                  leading: CircleAvatar(child: Text('${item.quantity}')),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => provider.updateQuantity(item.id, -1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => provider.updateQuantity(item.id, 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => provider.removeItem(item.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => provider.addSampleItem(),
      ),
    );
  }
}

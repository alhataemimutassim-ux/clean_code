import 'package:clean_architecture_example/inventory/state/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_example/inventory/pages/inventory_list_page.dart';

void main() {
  // inventory provider doesn't need external dependencies for this simple demo

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InventoryProvider()..loadItems(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(title: 'Warehouse Manager', home: const InventoryListPage());
  }
}

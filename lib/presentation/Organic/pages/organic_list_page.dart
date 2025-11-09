import 'dart:developer';

import 'package:clean_architecture_example/presentation/Organic/state/organic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganicListPage extends StatelessWidget {
  const OrganicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organic List')),
      body: Consumer<OrganicProvider>(
        builder: (context, organicProvider, child) {
          if (organicProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (organicProvider.error.isNotEmpty) {
            return Center(
              child: Text('Error to get organics: ${organicProvider.error}'),
            );
          } else if (organicProvider.organic.isEmpty) {
            return Center(child: Text('No organics found.'));
          } else {
            return ListView.builder(
              itemCount: organicProvider.organic.length,
              itemBuilder: (context, index) {
                final organic = organicProvider.organic[index];
                return Column(
                  children: [
                    if (index == 0)
                      Image.network(
                        'https://miro.medium.com/v2/resize:fit:1100/format:webp/1*VxwEfDbouPmln-MtFsFmYg.png',
                      ),
                    ListTile(
                      title: Text(organic.title),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(organic.snippet),
                          Text(organic.date.toString()),
                          Text(organic.position.toString()),
                          TextButton(
                            child: Text(organic.link),
                            onPressed: () {
                              log('Tapped on: ${organic.link}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    organic.title + '\n' + organic.link,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<OrganicProvider>(context, listen: false).fetchOrganics();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:clean_architecture_example/data/models/organic_models.dart';
import 'package:clean_architecture_example/domain/entities/organic.dart';
import 'package:clean_architecture_example/domain/repositories/organic_repository.dart';
import 'package:http/http.dart' as http;

class OrganicRepositoryImpl implements OrganicRepository {
  final http.Client client;

  OrganicRepositoryImpl({required this.client});

  @override
  Future<List<Organic>> getAllOrganic() async {
    final response = await client.get(
      Uri.parse(
        'https://google.serper.dev/search?q=apple+inc&apiKey=2a7b265768b9af561da915a0ff9482d16f9c6274',
      ),
    );

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> organicList = jsonData['organic'] ?? [];

      return organicList.map((json) => OrganicModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load organic results');
    }
  }
}

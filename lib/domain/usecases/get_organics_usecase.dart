import 'package:clean_architecture_example/domain/entities/organic.dart';
import 'package:clean_architecture_example/domain/repositories/organic_repository.dart';


class GetOrganicsUseCase {
  final OrganicRepository repository;

  GetOrganicsUseCase(this.repository);

  Future<List<Organic>> execute() async {
    return await repository.getAllOrganic();
  }
}

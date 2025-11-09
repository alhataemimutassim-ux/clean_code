
import 'package:clean_architecture_example/domain/entities/organic.dart';

abstract class OrganicRepository {
  Future<List<Organic>> getAllOrganic();
}

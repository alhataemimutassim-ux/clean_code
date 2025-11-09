import 'package:clean_architecture_example/domain/entities/organic.dart';

class OrganicModel extends Organic {
  OrganicModel({
    required super.title,
    required super.link,
    required super.snippet,
    required super.date,
    required super.position,
  });

  factory OrganicModel.fromJson(Map<String, dynamic> json) {
    return OrganicModel(
      title: json['title'],
      link: json['link'],
      snippet: json['snippet'],
      date: json['date'] ?? '__',
      position: json['position'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'snippet': snippet,
      'date': date,
      'position': position,
    };
  }
}

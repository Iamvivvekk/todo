// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todomodel {
  final int? id;
  final String title;
  final String description;
  final String? time;
  Todomodel({
    this.id,
    required this.title,
    required this.description,
    this.time,
  });

  Todomodel copyWith({
    int? id,
    String? title,
    String? description,
    String? time,
  }) {
    return Todomodel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'time': time,
    };
  }

  factory Todomodel.fromMap(Map<String, dynamic> map) {
    return Todomodel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todomodel.fromJson(String source) =>
      Todomodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todomodel(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant Todomodel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
  }
}

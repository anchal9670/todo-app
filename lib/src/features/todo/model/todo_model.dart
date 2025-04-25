import 'dart:convert';
import 'package:uuid/uuid.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));
String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  final String id;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? status;

  Task({String? id, this.title, this.description, this.date, this.status})
    : id = id ?? const Uuid().v4();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? status,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    status: status ?? this.status,
  );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date?.toIso8601String(),
    "status": status,
  };
}

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int? id;
  final int? userId;
  final String name;
  final int? realized;
  final DateTime? date;

  Task({
    this.id,
    required this.name,
    this.date,
    this.realized,
    this.userId,
  });

  Task copyWith(
      {int? id, int? userId, String? name, int? realized, DateTime? date}) {
    return Task(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        realized: realized ?? this.realized,
        userId: userId ?? this.userId);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int?,
      name: json['name'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      realized: json['realized'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'realized': instance.realized,
      'date': instance.date?.toIso8601String(),
    };

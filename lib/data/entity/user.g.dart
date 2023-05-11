// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      token: json['token'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String,
      picture: json['picture'] as String?,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'picture': instance.picture,
    };

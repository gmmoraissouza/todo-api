import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? token;
  final String? name;
  final String? email;
  final String username;
  final String password;
  final String? picture;

  User({
    this.token,
    this.id,
    this.name,
    this.email,
    required this.password,
    this.picture,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String? ?? 'Member',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'avatarUrl': avatarUrl,
      };

  @override
  List<Object?> get props => [id, name, email, role, avatarUrl];
}

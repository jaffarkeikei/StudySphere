import 'package:equatable/equatable.dart';

/// Model class for app users
class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? university;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isEmailVerified;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.university,
    this.photoUrl,
    required this.createdAt,
    this.lastLoginAt,
    required this.isEmailVerified,
  });

  /// Creates an empty user instance
  factory UserModel.empty() => UserModel(
    id: '',
    email: '',
    name: '',
    createdAt: DateTime.now(),
    isEmailVerified: false,
  );

  /// Creates a user from Firebase Auth and additional data
  factory UserModel.fromFirebase(Map<String, dynamic> data, String uid) {
    return UserModel(
      id: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      university: data['university'],
      photoUrl: data['photoUrl'],
      createdAt:
          data['createdAt'] != null
              ? (data['createdAt'] as DateTime)
              : DateTime.now(),
      lastLoginAt:
          data['lastLoginAt'] != null
              ? (data['lastLoginAt'] as DateTime)
              : null,
      isEmailVerified: data['isEmailVerified'] ?? false,
    );
  }

  /// Converts user to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'university': university,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
      'isEmailVerified': isEmailVerified,
    };
  }

  /// Creates a copy of the user with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? university,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      university: university ?? this.university,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    university,
    photoUrl,
    createdAt,
    lastLoginAt,
    isEmailVerified,
  ];
}

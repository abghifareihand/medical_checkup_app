import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponseModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final Timestamp timedate;

  UserResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.timedate,
  });

  factory UserResponseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserResponseModel(
      id: doc.id,
      name: data['name'],
      email: data['email'],
      role: data['role'],
      timedate: data['timedate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'timedate': timedate,
    };
  }
}

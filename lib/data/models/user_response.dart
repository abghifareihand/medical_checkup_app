class UserResponse {
  String uid;
  String name;
  String email;
  String role;

  UserResponse({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserResponse.fromMap(Map<String, dynamic> data) {
    return UserResponse(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}

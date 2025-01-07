// models/user_model.dart

class User {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  // Convert a User object to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Convert a Map from the database to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePictureUrl: map['profilePictureUrl'],
    );
  }
}

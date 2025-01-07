// models/contact_model.dart

class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  // Convert a Contact object to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  // Convert a Map from the database to a Contact object
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}

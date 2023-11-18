class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    firstName = json['firstName'] as String?;
    email = json['email'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
    };
  }
}

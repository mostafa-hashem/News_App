class UserModel {
  String id;
  final String firstName;
  final String lastName;
  String email;


  UserModel(
      {this.id = "",
        required this.firstName,
        required this.lastName,
        required this.email,});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    };
  }
}

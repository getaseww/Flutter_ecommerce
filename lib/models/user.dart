import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
class User {
  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.password});
  String id;
  String fullName;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"]);

  Map<String,dynamic> toJson()=>{
    "fullName":fullName,
    "email":email,
    "password":password,
  };
}

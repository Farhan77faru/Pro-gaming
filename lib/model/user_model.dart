// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phonenumber,
    this.image,
  });
  String email;
  String password;
  String id;
  String name;
  String phonenumber;
  String? image;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json["email"],
      password: json["password"],
      name: json["name"],
      phonenumber: json["phonenumber"],
      id: json["id"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "id": id,
        "image": image,
        "name": name,
        "phonenumber":phonenumber
      };

  UserModel copyWith({String? name, image, password,phonenumber}) => UserModel(
        id: id,
        email: email,
        image: image ?? this.image,
        name: name ?? this.name,
        phonenumber: phonenumber ?? this.phonenumber,
        password: password ?? this.password,
      );
}

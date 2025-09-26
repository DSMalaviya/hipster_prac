// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String? message;
  Data? data;
  String? token;

  SignupModel({this.message, this.data, this.token});

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "token": token,
  };
}

class Data {
  String? name;
  String? email;
  String? password;
  String? id;
  int? v;

  Data({this.name, this.email, this.password, this.id, this.v});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "_id": id,
    "__v": v,
  };
}

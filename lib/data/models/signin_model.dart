// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  String? message;
  String? token;

  SignInModel({this.message, this.token});

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      SignInModel(message: json["message"], token: json["token"]);

  Map<String, dynamic> toJson() => {"message": message, "token": token};
}

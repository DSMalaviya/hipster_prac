// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) =>
    UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  String? message;
  List<User>? users;

  UserListModel({this.message, this.users});

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    message: json["message"],
    users: json["users"] == null
        ? []
        : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "users": users == null
        ? []
        : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  String? id;
  String? name;
  String? email;
  int? v;
  String? profileImageUrl;

  User({this.id, this.name, this.email, this.v, this.profileImageUrl});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    v: json["__v"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "__v": v,
    "profileImageUrl": profileImageUrl,
  };
}

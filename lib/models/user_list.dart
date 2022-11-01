// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserList> userListFromJson(String str) =>
    List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  UserList({
    required this.users,
  });

  List<User> users;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.name,
    required this.id,
    required this.atype,
  });

  String name;
  String id;
  String atype;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        atype: json["atype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "atype": atype,
      };
}

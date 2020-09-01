import 'package:flutter/material.dart';

class User {
  final String name;
  final String ueId;

  User({
    @required this.name,
    @required this.ueId,
  });

  static fromMap(Map<String, dynamic> map) {
    return new User(name: map['name'], ueId: map['ueId']);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "ueId": this.ueId,
    };
  }
}

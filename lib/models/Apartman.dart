import 'package:flutter/material.dart';

class Apartman {
  final String title;
  final int capacity;
  final String id;
  String image;
  double totalIncome = 0;

  Apartman({
    @required this.title,
    @required this.id,
    @required this.capacity,
    this.totalIncome = 0,
    this.image = "",
  });

  static Apartman fromMap(Map<String, dynamic> map) {
    Apartman _newApartman = new Apartman(
        title: map['title'], id: map['id'], capacity: map['capacity']);
    if (map['totalIncome'] != null)
      _newApartman.totalIncome = map['totalIncome'];
    if (map['image'] != null) _newApartman.image = map['image'];
    return _newApartman;
  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "capacity": this.capacity,
      "id": this.id,
      "image": this.image,
      "totalIncome": this.totalIncome,
    };
  }
}

import 'package:flutter/material.dart';
import 'dart:core';

import '../models/Apartman.dart';
import '../models/Reservation.dart';
import '../models/User.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbProvider {
  DbProvider._();
  static final DbProvider db = DbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      _database = await _initDb();
      return _database;
    }
  }

  Future<Database> _initDb() async {
    return await openDatabase(
        join(await getDatabasesPath(), "apartmaniDatabase"),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE apartmani(
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT,
            totalIncome DOUBLE,
            capacity INTEGER
          )
        ''');
      await db.execute('''
        CREATE TABLE reservations(
          apartmanId TEXT,
          reservationId TEXT,
          userID TEXT,
          price DOUBLE,
          start TEXT,
          end TEXT,
          customIme TEXT,
          approved INT
        )
      ''');

      await db.execute('''
        CREATE TABLE users(
         ueId TEXT,
         name TEXT
        )
      ''');
    });
  }

  Future<Map<String, dynamic>> getApartmanById(String id) async {
    final db = await database;
    final apartman =
        await db.rawQuery('''SELECT * FROM apartmani WHERE id=?''', [id]);
    if (apartman.isEmpty)
      return null;
    else
      return apartman.first;
  }

  Future<List<Map<String, dynamic>>> getApartmans() async {
    final db = await database;
    final apartmani = await db.rawQuery('''SELECT * FROM apartmani''');
    return apartmani;
  }

  Future<void> insertApartman(Map<String, dynamic> map) async {
    final db = await database;
    final response = await db.rawInsert('''
      INSERT INTO apartmani(id,title,image,totalIncome,capacity)
      VALUES(?,?,?,?,?)
      ''', [
      map['id'],
      map['title'],
      map['image'],
      map['totalIncome'],
      map['capacity'],
    ]);
  }

}

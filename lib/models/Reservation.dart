import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class Reservation {
  final String apartmanId;
  final String reservationId;
  final String userID;
  final DateTime start;
  final DateTime end;
  String
      customIme; //ako vlasnik napravim CUSTOM IME, ako ima ime ond aje od vlasnika napravljen !!!!
  bool approved = false;
  double price;

  Reservation(
      {@required this.apartmanId,
      @required this.reservationId,
      @required this.end,
      @required this.start,
      @required this.userID,
      this.customIme = "",
      this.price = 0.0,
      this.approved = false});

  static Reservation fromMap(Map<String, dynamic> map) {
    Reservation _newReservation = new Reservation(
      apartmanId: map['apartmanId'],
      reservationId: map['reservationId'],
      end: DateTime.parse(map['end']),
      start: DateTime.parse(map['start']),
      userID: map['userID'],
    );
    if (map['customIme'] != null) {
      _newReservation.customIme = map['customIme'];
    }
    if (map['price'] != null) _newReservation.price = map['price'];
    return _newReservation;
  }

  Map<String, dynamic> toMap() {
    return {
      "apartmanId": this.apartmanId,
      "reservationId": this.reservationId,
      "userID": this.userID,
      "start": this.start,
      "end": this.end,
      "customIme": this.customIme,
      "approved": this.approved,
    };
  }
}

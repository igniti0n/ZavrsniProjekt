import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../models/Reservation.dart';

class Reservations with ChangeNotifier {
  List<Reservation> _reservations = [
    Reservation(
        apartmanId: "1",
        reservationId: "1",
        end: DateTime.now().add(Duration(days: 10)),
        approved: true,
        start: DateTime.now(),
        userID: "11"),
    Reservation(
        apartmanId: "1",
        reservationId: "2",
        end: DateTime.now().add(Duration(days: 16)),
        approved: true,
        start: DateTime.now().add(Duration(days: 14)),
        userID: "22"),
    Reservation(
        apartmanId: "1",
        reservationId: "3",
        end: DateTime.now().add(Duration(days: 10)),
        approved: false,
        start: DateTime.now(),
        userID: "33"),
    Reservation(
        apartmanId: "1",
        reservationId: "4",
        end: DateTime.now().add(Duration(days: 10)),
        approved: true,
        start: DateTime.now(),
        userID: "44"),
  ];

  List<Reservation> getReservations() {
    return [..._reservations];
  }

  List<Reservation> getReservationsByApartmanNotApproved(String apartmanId) {
    return _reservations
        .where((element) =>
            element.apartmanId == apartmanId && element.approved == false)
        .toList() as List<Reservation>;
  }

  List<Reservation> getReservationsByApartmanApproved(String apartmanId) {
    return _reservations
        .where((element) =>
            element.apartmanId == apartmanId && element.approved == true)
        .toList() as List<Reservation>;
  }

  Reservation getReservationById(String id) {
    final val = _reservations.firstWhere(
        (element) => element.reservationId == id,
        orElse: () => null);
  }

  int deleteReservation(String id) {
    final int index =
        _reservations.indexWhere((element) => element.reservationId == id);

    if (index >= 0) {
      _reservations.removeAt(index);
      print("NADJEN ID");
      notifyListeners();
    }
    print("Nije nadjen id, index: $index");
    return index;
  }

  bool validateDate(DateTime begin, DateTime end, DateTime picked) {
    if (picked.year <= end.year &&
        picked.month <= end.month &&
        picked.day <= end.day) if (begin.day <= picked.day) return false;
    return true;
  }

  bool validatePickedDateAllReservations(DateTime begin) {
    bool valid = true;
    _reservations.forEach((element) {
      if (!(validateDate(element.start, element.end, begin))) valid = false;
    });
    return valid;
  }

  bool validatePickedDateRange(DateTime begin, DateTime end) {
    bool valid = true;
    _reservations.forEach((element) {
      int dg = element.start.day;
      int gg = element.end.day;
      int start = begin.day;
      int finish = end.day;
      if (finish > dg) {
        if (finish < gg || start < gg) valid = false;
      }
    });
    return valid;
  }

  DateTime getFirstValidDate() {
    DateTime firstValid = DateTime.now();
    while (!validatePickedDateAllReservations(firstValid)) {
      firstValid = firstValid.add(Duration(days: 1));
    }

    return firstValid;
  }

  void approveReservation(String id) {
    final int index =
        _reservations.indexWhere((element) => element.reservationId == id);
    if (index >= 0) {
      _reservations.elementAt(index).approved = true;
      notifyListeners();
    }
  }

  void addReservation(Reservation newReservation) {
    _reservations.add(newReservation);
    notifyListeners();
  }
}

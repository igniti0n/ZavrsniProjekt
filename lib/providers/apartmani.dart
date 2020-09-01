import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Apartman.dart';

class Apartmani with ChangeNotifier {
  List<Apartman> apartmani = [
    Apartman(
        title: "Prvi apartman",
        id: "1",
        image: "assets/images/temp1.jpg",
        capacity: 4),
    Apartman(
        title: "Drugi apartman",
        id: "2",
        image: "assets/images/temp2.jpg",
        capacity: 4),
    Apartman(
        title: "Treci apartman",
        id: "3",
        image: "assets/images/temp3.jpg",
        capacity: 4),
    Apartman(
        title: "cetvrti apartman",
        id: "4",
        image: "assets/images/temp3.jpg",
        capacity: 4)
  ];

  List<Apartman> getApartmans() {
    return [...apartmani];
  }

  Apartman getApartmanById(String id) {
    return apartmani.firstWhere((element) => element.id == id,
        orElse: () => null);
  }

  void occupieApartman(String id) {
    int index = apartmani.indexWhere((element) => element.id == id);
    if (index != -1) {
      var el = apartmani.elementAt(index);

      notifyListeners();
      return;
    }
    print("GREŠKA PRI OCCUPIE");
  }

  void chargeApartman(String id, double price) {
    int index = apartmani.indexWhere((element) => element.id == id);

    if (index != -1) {
      var el = apartmani.elementAt(index);

      //el.incomeThisMonth += price;
      el.totalIncome += price;
      notifyListeners();
      return;
    }
    print("GREŠKA PRI CHARGE");
  }

  void chargeApartmanYear(String id, double price) {
    int index = apartmani.indexWhere((element) => element.id == id);

    if (index != -1) {
      var el = apartmani.elementAt(index);

      el.totalIncome += price;
      notifyListeners();
      return;
    }
    print("GREŠKA PRI CHARGE YEAR");
  }

  void freeApartman(String id) {
    int index = apartmani.indexWhere((element) => element.id == id);
    if (index != -1) {
      notifyListeners();
      return;
    }
    print("GREŠKJA PRI FREE");
  }

  void refundApartman(String id, price) {
    int index = apartmani.indexWhere((element) => element.id == id);
    if (index != -1) {
      var el = apartmani.elementAt(index);

      //el.incomeThisMonth -= price;
      el.totalIncome -= price;
      notifyListeners();
      return;
    }
    print("GREŠKA PRI REFUNDU");
  }
}

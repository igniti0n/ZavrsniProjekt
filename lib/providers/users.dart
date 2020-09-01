import 'package:flutter/cupertino.dart';

import '../models/User.dart';

class Users with ChangeNotifier {
  List<User> _users = [
    User(name: "Ivan Štajcer", ueId: "11"),
    User(name: "Davor Štajcer", ueId: "22"),
    User(name: "Marko Boras", ueId: "33"),
    User(name: "Sandro Blavicki", ueId: "44"),
    User(name: "Ivo Nedić", ueId: "55"),
  ];

  User getUserById(String ueId) {
    return _users.firstWhere((element) => element.ueId == ueId, orElse: null);
  }

  String getUserNameById(String ueId) {
    final User user =
        _users.firstWhere((element) => element.ueId == ueId, orElse: null);
    if (user == null) return "User null";
    return user.name;
  }

  void addUser(User newUser) {
    _users.add(newUser);
    notifyListeners();
  }

  void deleteUser(String ueId) {
    final int _index = _users.indexWhere((element) => element.ueId == ueId);
    if (_index > 0) {
      _users.removeAt(_index);
      notifyListeners();
    }
  }
}

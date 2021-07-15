import 'package:flutter/foundation.dart';

class MMber extends ChangeNotifier {
  String? id;
  String? username;
  String? email;
  String? userType;

  void updateMMber(String id, String username,String email,String userType) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.userType = userType;

    print(id);
    print(username);
    print(email);
    print(userType);

    notifyListeners();
  }
}
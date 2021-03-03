import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gamesman/Screens/Signup/users.dart';

enum Status { Uninitialized, Authenticating, Unauthenticated, Authenticated }

class Userprovider with ChangeNotifier {
  FirebaseAuth auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  UserServices userServices = UserServices();

  Userprovider.initialize() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(onstatechanged);
  }

  Future<bool> signin(String email, String pass) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signup(String name, String email, String pass) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((user) {
        Map<String, dynamic> values = {
          "name": name,
          "email": email,
          "userid": user.user.uid,
          "Cart": [],
        };
        userServices.createUser(values);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signout() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> onstatechanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}

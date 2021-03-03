import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Firestore firestore = Firestore.instance;
  String ref = "users";

  createUser(Map data) {
    firestore.collection(ref).document(data["userid"]).setData(data);
  }

  Future getusers() async {
    firestore.collection(ref).document("userId").snapshots();
  }
}

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Homescreen/components/Products.dart';
import 'package:the_gamesman/Screens/Homescreen/components/appdrawer.dart';
import 'package:the_gamesman/Screens/Homescreen/components/imagecarousel.dart';
import 'package:the_gamesman/Screens/Homescreen/components/horizontallist.dart';
import 'package:the_gamesman/Screens/Mycart/Mycart.dart';
import 'package:the_gamesman/Screens/app_provider.dart';
import 'package:the_gamesman/Screens/productservice.dart';
import 'package:the_gamesman/constraints.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String bullet = "\u2022 ";
  FirebaseUser currentuser;

  @override
  void initState() {
    super.initState();
    loadcurrentuser();
  }

  void loadcurrentuser() async {
    await _auth.currentUser().then((user) {
      setState(() {
        this.currentuser = user;
      });
    });
  }

  String userid() {
    return currentuser != null ? currentuser.uid : null;
  }

  String username() {
    return currentuser.displayName;
  }

  String email() {
    return currentuser != null ? currentuser.email : null;
  }

  @override
  Widget build(BuildContext context) {
    // Appprovider appprovider = Provider.of<Appprovider>(context);

    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(userid())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          DocumentSnapshot userdetails = snapshot.data;
          return !snapshot.hasData
              ? Text('please wait')
              : Scaffold(
                  backgroundColor: kprimarylightcolor,
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Text(
                      'The Gamesmen',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: null),
                      Badge(
                        alignment: Alignment.center,
                        position: BadgePosition.topRight(top: 3, right: 4),
                        badgeContent: Text('${userdetails['Cart'].length}'),
                        child: IconButton(
                            icon:
                                Icon(Icons.shopping_cart, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mycart()));
                            }),
                      ),
                    ],
                  ),
                  drawer: Appdrawer(),
                  body: ListView(
                    children: <Widget>[
                      Horizontallist(),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Imagecarousel(
                        images: [
                          AssetImage(
                            'assets/images/graphiccard.png',
                          ),
                          AssetImage('assets/images/gamingpc.jpg'),
                          AssetImage('assets/images/keyboard.jpg'),
                          AssetImage('assets/images/ps4.jpg'),
                          AssetImage('assets/images/monitor.jpg'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Top Selections',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 394.0,
                        child: Products(),
                      )
                    ],
                  ),
                );
        });
  }
}

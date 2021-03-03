import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_gamesman/Screens/Homescreen/components/appdrawer.dart';
import 'package:the_gamesman/Screens/Mycart/cartproducts.dart';
import 'package:the_gamesman/constraints.dart';

class Mycart extends StatefulWidget {
  @override
  _MycartState createState() => _MycartState();
}

class _MycartState extends State<Mycart> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser currentuser;

  @override
  void initState() {
    super.initState();
    loadcurrentuser();
  }

  void  loadcurrentuser() async{
    await _auth.currentUser().then((user) {
      setState(() {
        this.currentuser = user;
      });
    });
  }

  String userid() {
    return currentuser==null?' ':currentuser.uid;
  }

  String username() {
    return currentuser==null?'':currentuser.displayName;
  }

  String email() {
    return currentuser==null?'':currentuser.email;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(userid())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          DocumentSnapshot userdetails = snapshot.data;
          double total = 0;
          for (int i = 0; i < userdetails['Cart'].length; i++)
            total += userdetails['Cart'][i]['price'] *
                userdetails['Cart'][i]['quantity'];
            if(snapshot.hasData){
              if(snapshot.data!=null){
          return  Scaffold(
                  backgroundColor: kprimarylightcolor,
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Text(
                      'My Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  body: Cartproducts(),
                  bottomNavigationBar: Container(
                    color: kprimarylightcolor,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: Text('Total'),
                          subtitle: Text('$total'),
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: kprimarycolor,
                        )),
                      ],
                    ),
                  ),
                );
          }
          else return CircularProgressIndicator(); 
            }
           });
        
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Login/login_screen.dart';
import 'package:the_gamesman/Screens/userprovider.dart';

class Appdrawer extends StatefulWidget {
  @override
  _AppdrawerState createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser currentuser;

  @override
  void initState() {
    super.initState();
    loadcurrentuser();
  }

  void loadcurrentuser() async{
   await _auth.currentUser().then((user) {
      setState(() {
        this.currentuser = user;
      });
    });
  }

  String username() {
    return currentuser==null?'':currentuser.displayName;
  }

  String email() {
    return currentuser==null?'':currentuser.email;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(email()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.vox-cdn.com/thumbor/Oi6jzvQzWetJGlkpwLqlP1L9p28=/0x0:5568x3712/1200x800/filters:focal(2858x720:3748x1610)/cdn.vox-cdn.com/uploads/chorus_image/image/62207705/922984782.jpg.0.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Homepage'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Account'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('My orders'),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          InkWell(
            onTap: () {
              user.signout();
              // signout().then((value) => Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Loginscreen(),
              //     )));
            },
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Logout'),
            ),
          ),
          Divider(),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          )),
        ],
      ),
    );
  }
}

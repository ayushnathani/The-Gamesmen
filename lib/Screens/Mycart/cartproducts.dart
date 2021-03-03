import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_gamesman/constraints.dart';

class Cartproducts extends StatefulWidget {
  @override
  _CartproductsState createState() => _CartproductsState();
}

class _CartproductsState extends State<Cartproducts> {
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
    return currentuser==null?'jbj':currentuser.uid;
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
      stream:
          Firestore.instance.collection('users').document(userid()).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Text('please wait')
            : ListView.builder(
                itemCount: snapshot.data['Cart'].length,
                itemBuilder: (context, index) {
                  DocumentSnapshot userdetails = snapshot.data;
                  return Singlecartproduct(
                    cartprod_name: userdetails['Cart'][index]['name'],
                    cartprod_oldprice: userdetails['Cart'][index]['oldprice'],
                    cartprod_picture: userdetails['Cart'][index]['Images'],
                    cartprod_price: userdetails['Cart'][index]['price'],
                    cartprod_brand: userdetails['Cart'][index]['brand'],
                    cartprod_category: userdetails['Cart'][index]['category'],
                    cartprod_quantity: userdetails['Cart'][index]['quantity'],
                  );
                });
      },
    );
  }
}

class Singlecartproduct extends StatefulWidget {
  final cartprod_name;
  final List cartprod_picture;
  final cartprod_oldprice;
  final cartprod_price;
  final cartprod_brand;
  final cartprod_category;
  int cartprod_quantity;

  Singlecartproduct(
      {Key key,
      this.cartprod_name,
      this.cartprod_picture,
      this.cartprod_oldprice,
      this.cartprod_price,
      this.cartprod_brand,
      this.cartprod_category,
      this.cartprod_quantity})
      : super(key: key);

  @override
  _SinglecartproductState createState() => _SinglecartproductState();
}

class _SinglecartproductState extends State<Singlecartproduct> {
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
    return currentuser==null?'cvxzx':currentuser.uid;
  }

  String username() {
    return currentuser==null?'':currentuser.displayName;
  }

  String email() {
    return currentuser==null?'':currentuser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.network(
              widget.cartprod_picture[0],
              cacheWidth: 60,
            ),
            title: Text(widget.cartprod_name),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Prop 1'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'P1',
                        style: TextStyle(color: kprimarycolor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: Text('Prop 2'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'P2',
                        style: TextStyle(color: kprimarycolor),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\$${widget.cartprod_price}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 65,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                        iconSize: 12,
                        icon: Icon(
                          Icons.remove,
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection('users')
                              .document(userid())
                              .updateData({
                            'Cart': FieldValue.arrayRemove([
                              {
                                'name': widget.cartprod_name,
                                'category': widget.cartprod_category,
                                'brand': widget.cartprod_brand,
                                'Images': widget.cartprod_picture,
                                'quantity': widget.cartprod_quantity,
                                'price': widget.cartprod_price,
                                'oldprice': widget.cartprod_oldprice
                              }
                            ])
                          });
                          setState(() {
                            widget.cartprod_quantity--;
                          });

                          Firestore.instance
                              .collection('users')
                              .document(userid())
                              .updateData({
                            'Cart': FieldValue.arrayUnion([
                              {
                                'name': widget.cartprod_name,
                                'category': widget.cartprod_category,
                                'brand': widget.cartprod_brand,
                                'Images': widget.cartprod_picture,
                                'quantity': widget.cartprod_quantity,
                                'price': widget.cartprod_price,
                                'oldprice': widget.cartprod_oldprice
                              }
                            ])
                          });
                        }),
                  ),
                  Expanded(
                    child: Center(
                      child: widget.cartprod_quantity < 1
                          ? Text('1')
                          : Text(
                              '${widget.cartprod_quantity}',
                            ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        iconSize: 12,
                        icon: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection('users')
                              .document(userid())
                              .updateData({
                            'Cart': FieldValue.arrayRemove([
                              {
                                'name': widget.cartprod_name,
                                'category': widget.cartprod_category,
                                'brand': widget.cartprod_brand,
                                'Images': widget.cartprod_picture,
                                'quantity': widget.cartprod_quantity,
                                'price': widget.cartprod_price,
                                'oldprice': widget.cartprod_oldprice
                              }
                            ])
                          });
                          setState(() {
                            widget.cartprod_quantity++;
                          });
                          Firestore.instance
                              .collection('users')
                              .document(userid())
                              .updateData({
                            'Cart': FieldValue.arrayUnion([
                              {
                                'name': widget.cartprod_name,
                                'category': widget.cartprod_category,
                                'brand': widget.cartprod_brand,
                                'Images': widget.cartprod_picture,
                                'quantity': widget.cartprod_quantity,
                                'price': widget.cartprod_price,
                                'oldprice': widget.cartprod_oldprice
                              }
                            ])
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                color: kprimarycolor,
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Favourites',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              )),
              Expanded(
                  child: FlatButton.icon(
                color: kprimarycolor,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                label: Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Firestore.instance
                      .collection('users')
                      .document(userid())
                      .updateData({
                    'Cart': FieldValue.arrayRemove([
                      {
                        'name': widget.cartprod_name,
                        'category': widget.cartprod_category,
                        'brand': widget.cartprod_brand,
                        'Images': widget.cartprod_picture,
                        'quantity': widget.cartprod_quantity,
                        'price': widget.cartprod_price,
                        'oldprice': widget.cartprod_oldprice
                      }
                    ])
                  });
                },
              )),
            ],
          )
        ],
      ),
    );
  }
}

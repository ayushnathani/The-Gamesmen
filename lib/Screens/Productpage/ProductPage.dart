import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Homescreen/components/appdrawer.dart';
import 'package:the_gamesman/Screens/Mycart/Mycart.dart';
import 'package:the_gamesman/Screens/Mycart/productsincart.dart';
import 'package:the_gamesman/Screens/Productpage/similarproducts.dart';
import 'package:the_gamesman/Screens/app_provider.dart';
import 'package:the_gamesman/constraints.dart';
import 'package:http/http.dart' as http;

class Productpage extends StatefulWidget {
  final product_name;
  final List product_picture;
  final product_oldprice;
  final product_price;
  final product_brand;
  final product_category;
  final product_quantity;
  final product_featured;
  final product_onsale;
  final product_url;

  var quantityofproductincart = 1;

  Productpage(
      {Key key,
      this.product_name,
      this.product_picture,
      this.product_oldprice,
      this.product_price,
      this.product_brand,
      this.product_category,
      this.product_quantity,
      this.product_featured,
      this.product_onsale,
      this.product_url});

  @override
  _ProductpageState createState() => _ProductpageState();
}

class Post {
  final String subject;
  final String body;

  Post({this.subject, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      subject: json['subject'],
      body: json['body'],
    );
  }
}

class _ProductpageState extends State<Productpage> {
  // Productsincartservice productsincartservice = Productsincartservice();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String bullet = "\u2022 ";
  FirebaseUser currentuser;
  Future<List> future;
  Future<List> details;
  Future<List<Post>> fetchPost() async {
    String url = 'https://run.mocky.io/v3/9f01220c-74f5-491e-80b3-4ed26197770a';
    http.Response response = await http.get(url);
    String content = response.body;
    List collection = json.decode(content);
    List<Post> details = collection.map((json) => Post.fromJson(json)).toList();

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return details;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    loadcurrentuser();

    // fetch();
  }

  // void fetch() async {
  //   future = fetchdata();
  //   details = await future;
  // }

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
    //Appprovider appprovider = Provider.of<Appprovider>(context);
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
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Text(
                      widget.product_name,
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
                        position: BadgePosition(top: 3, right: 4),
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 250.0,
                        child: GridTile(
                            child: Container(
                          color: Colors.white,
                          child: Image.network(widget.product_picture[0]),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          widget.product_name,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Text(
                                "\$${widget.product_price}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Text(
                                "\$${widget.product_price}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Text(
                                "\$${widget.product_oldprice - widget.product_price} off",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  widget.quantityofproductincart--;
                                });
                              }),
                          Text('${widget.quantityofproductincart}'),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  widget.quantityofproductincart++;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: FlatButton(
                                  color: kprimarycolor,
                                  onPressed: () {},
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          IconButton(
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: kprimarycolor,
                              ),
                              onPressed: () async {
                                Firestore.instance
                                    .collection('users')
                                    .document(userid())
                                    .setData({
                                  'Cart': FieldValue.arrayUnion([
                                    {
                                      'name': widget.product_name,
                                      'category': widget.product_category,
                                      'brand': widget.product_brand,
                                      'Images': widget.product_picture,
                                      'quantity':
                                          widget.quantityofproductincart,
                                      'price': widget.product_price,
                                      'oldprice': widget.product_oldprice
                                    }
                                  ])
                                }, merge: true);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {})
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 8,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          'Highlights',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(bullet + 'ddhfasdh')),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(bullet + 'ddhfasdh')),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(bullet + 'ddhfasdh')),
                      Divider(),
                      ExpansionTile(
                          initiallyExpanded: true,
                          title: Text('All Details'),
                          children: <Widget>[
                            FutureBuilder<List<Post>>(
                              future: fetchPost(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  if(snapshot.data!=null){
                                  return Table(
                                    border: TableBorder.all(),
                                    children: [
                                      for (var item in snapshot.data)
                                        TableRow(children: [
                                          Column(
                                            children: [Text(item.subject)],
                                          ),
                                          Column(
                                            children: [Text(item.body)],
                                          )
                                        ])
                                    ],
                                  );
                                }
                                }
                                else return CircularProgressIndicator();
                              },
                            )
                          ]),
                      Divider(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          'Similar Products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 394.0,
                        child: SimilarProducts(),
                      )
                    ],
                  ));
        });
  }

  // void validateAndAdd() async {
  //   Map<String, dynamic> cart = {
  //     'name': widget.product_name,
  //     'category': widget.product_category,
  //     'brand': widget.product_brand,
  //     'Images': widget.product_picture,
  //     'quantity': widget.quantityofproductincart,
  //     'price': widget.product_price,
  //     'oldprice': widget.product_oldprice
  //   };

  //   Firestore.instance
  //       .collection('users')
  //       .document(userid())
  //       .setData({"MyCart": cart}, merge: true);

  // productsincartservice.uploadProductincart(
  //     productname: widget.product_name,
  //     price: widget.product_price,
  //     brand: widget.product_brand,
  //     category: widget.product_category,
  //     images: widget.product_picture,
  //     oldprice: widget.product_oldprice,
  //     quantityofproductsincart: widget.quantityofproductincart);
}

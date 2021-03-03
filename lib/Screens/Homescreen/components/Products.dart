import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:the_gamesman/Screens/Productpage/ProductPage.dart';

import 'package:the_gamesman/constraints.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    // Appprovider appprovider = Provider.of<Appprovider>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('Products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Text('please wait')
            : GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot products = snapshot.data.documents[index];
                  return Single_product(
                    prod_name: products['name'],
                    prod_picture: products['Images'],
                    prod_oldprice: products['oldprice'],
                    prod_price: products['price'],
                    prod_brand: products['brand'],
                    prod_category: products['category'],
                    prod_quantity: products['quantity'],
                    prod_url: products['detailsurl'],
                  );
                },
              );
      },
    );
  }
}

class Single_product extends StatelessWidget {
  final prod_name;
  final List prod_picture;
  final prod_oldprice;
  final prod_price;
  final prod_brand;
  final prod_category;
  final prod_quantity;
  final featuredproduct;
  final productonsale;
  final prod_url;

  Single_product(
      {Key key,
      this.prod_name,
      this.prod_picture,
      this.prod_oldprice,
      this.prod_price,
      this.prod_brand,
      this.prod_category,
      this.prod_quantity,
      this.featuredproduct,
      this.productonsale, this.prod_url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: kprimarylightcolor,
        child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Productpage(
                        product_name: prod_name,
                        product_oldprice: prod_oldprice,
                        product_picture: prod_picture,
                        product_price: prod_price,
                        product_brand: prod_brand,
                        product_category: prod_category,
                        product_quantity: prod_quantity,
                        product_url: prod_url,
                      ))),
              child: GridTile(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      prod_picture[0],
                      cacheWidth: 50,
                      cacheHeight: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                        prod_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        '\$$prod_price',
                        style: TextStyle(fontSize: 19, color: Colors.blue),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        '\$$prod_oldprice',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
                // footer: Container(
                //   color: Colors.white54,
                //   child: ListTile(
                //     title: Text(prod_name),
                //     subtitle: Text('\$$prod_price'),
                //   ),
                // ),
                // child: Image.asset(
                //   prod_picture,
                //   fit: BoxFit.cover,
                // )
              ),
            ),
          ),
        ));
  }
}

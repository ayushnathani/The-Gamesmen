import 'package:flutter/material.dart';
import 'package:the_gamesman/Screens/Productpage/ProductPage.dart';
import 'package:the_gamesman/constraints.dart';

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var list = [
    {
      "name": "Laptop",
      "picture": "assets/images/gamingpc.jpg",
      "oldprice": 120,
      "price": 50,
    },
    {
      "name": "GPU",
      "picture": "assets/images/gamingpc.jpg",
      "oldprice": 120,
      "price": 50,
    },
    {
      "name": "CPU",
      "picture": "assets/images/gamingpc.jpg",
      "oldprice": 120,
      "price": 50,
    },
    {
      "name": "Mouse",
      "picture": "assets/images/gamingpc.jpg",
      "oldprice": 120,
      "price": 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SimilarSingle_product(
          prod_name: list[index]['name'],
          prod_picture: list[index]['picture'],
          prod_oldprice: list[index]['oldprice'],
          prod_price: list[index]['price'],
        );
      },
    );
  }
}

class SimilarSingle_product extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_oldprice;
  final prod_price;

  const SimilarSingle_product(
      {Key key,
      this.prod_name,
      this.prod_picture,
      this.prod_oldprice,
      this.prod_price})
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
                      ))),
              child: GridTile(
                child: Column(
                  children: <Widget>[
                    Image.asset(prod_picture),
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

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:the_gamesman/Screens/productfetch.dart';
// import 'package:the_gamesman/Screens/productservice.dart';

// class Appprovider with ChangeNotifier {
//   List<Productfetch> _products = [];
//   List<Productfetch> _productsincart = [];

//   Productservices productservices = Productservices();

//   Appprovider() {
//     getProducts();
//     getproductsincart();
//   }

//   List<Productfetch> get products => _products;
//   List<Productfetch> get productsincart => _productsincart;

//   void getProducts() async {
//     _products = await productservices.getProducts();
//     notifyListeners();
//   }

//   void getproductsincart() async {
//     _productsincart = await productservices.getProductsincart();
//     notifyListeners();
//   }
// }

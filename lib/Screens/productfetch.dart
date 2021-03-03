// import 'package:cloud_firestore/cloud_firestore.dart';

// class Productfetch {
//   static const NAME = 'name';
//   static const BRAND = 'brand';
//   static const CATEGORY = 'category';
//   static const PRICE = 'price';
//   static const QUANTITY = 'quantity';
//   static const IMAGES = 'Images';
//   static const OLDPRICE = 'oldprice';

//   String _name;
//   String _brand;
//   String _category;
//   double _price;
//   int _quantity;
//   List _images;
//   int _oldprice;

//   String get name => _name;
//   String get brand => _brand;
//   String get category => _category;
//   double get price => _price;
//   int get quantity => _quantity;
//   List get images => _images;
//   int get oldprice => _oldprice;

//   Productfetch.fromSnapshot(DocumentSnapshot snapshot) {
//     Map data = snapshot.data;
//     _name = data[NAME];
//     _brand = data[BRAND];
//     _category = data[CATEGORY];
//     _price = data[PRICE];
//     _quantity = data[QUANTITY];
//     _images = data[IMAGES];
//     _oldprice = data[OLDPRICE];
//     //  _images = toList(data[IMAGES]);
//     // _images = data[IMAGES].toList();
//   }
// }

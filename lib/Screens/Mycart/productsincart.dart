// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

// class Productsincartservice {
//   Firestore firestore = Firestore.instance;
//   String ref = 'Products in cart';
//   void uploadProductincart({
//     String productname,
//     String category,
//     String brand,
//     List images,
//     int quantityofproductsincart,
//     double price,
//     int oldprice,
//   }) {
//     var id = Uuid();
//     String productincartid = id.v1();
//     firestore.collection(ref).document(productincartid).setData({
//       'name': productname,
//       'category': category,
//       'brand': brand,
//       'Images': images,
//       'quantity': quantityofproductsincart,
//       'price': price,
//       'oldprice': oldprice
//     });
//   }
// }

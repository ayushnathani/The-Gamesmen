// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:the_gamesman/Screens/productfetch.dart';

// class Productservices {
//   Firestore firestore = Firestore.instance;
//   String ref = 'Products';
//   String ref2 = 'Products in cart';

//   Future<List<Productfetch>> getProducts() =>
//       firestore.collection(ref).getDocuments().then((snaps) {
//         List<Productfetch> products = [];
//         // snaps.documents.map(
//         //     (snapshot) => products.add(Productfetch.fromSnapshot(snapshot)));
//         for (int i = 0; i < snaps.documents.length; i++)
//           products.add(Productfetch.fromSnapshot(snaps.documents[i]));
//         return products;
//       });

//   Future<List<Productfetch>> getProductsincart() =>
//       firestore.collection(ref2).getDocuments().then((snaps) {
//         List<Productfetch> productsincart = [];
//         // snaps.documents.map(
//         //     (snapshot) => products.add(Productfetch.fromSnapshot(snapshot)));
//         for (int i = 0; i < snaps.documents.length; i++)
//           productsincart.add(Productfetch.fromSnapshot(snaps.documents[i]));
//         return productsincart;
//       });
// }

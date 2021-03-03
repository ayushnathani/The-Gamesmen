import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Imagecarousel extends StatelessWidget {
  final List<AssetImage> images;
  const Imagecarousel({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: images,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(seconds: 1),
        dotSize: 2,
        indicatorBgPadding: 2.0,
        overlayShadow: true,
        dotBgColor: Colors.transparent,
        autoplayDuration: Duration(seconds: 3),
        showIndicator: true,
      ),
    );
  }
}

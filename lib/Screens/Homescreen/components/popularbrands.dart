import 'package:flutter/material.dart';

class Horizontallist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Popularbrand(
            imagelocation: 'assets/icons/cabinet.png',
            imagecaption: 'Cabinets',
          ),
          Popularbrand(
            imagelocation: 'assets/icons/ram.png',
            imagecaption: 'Ram',
          ),
          Popularbrand(
            imagelocation: 'assets/icons/hdd.png',
            imagecaption: 'Hard Disk',
          ),
          Popularbrand(
            imagelocation: 'assets/icons/ssd.png',
            imagecaption: 'SSD',
          ),
          Popularbrand(
            imagelocation: 'assets/icons/grahiccard.jpg',
            imagecaption: 'Graphic Cards',
          ),
          Popularbrand(
            imagelocation: 'assets/icons/ssd.png',
            imagecaption: 'SSD',
          ),
        ],
      ),
    );
  }
}

class Popularbrand extends StatelessWidget {
  final String imagelocation;
  final String imagecaption;

  const Popularbrand({Key key, this.imagelocation, this.imagecaption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 120.0,
          height: 120.0,
          child: ListTile(
            title: Image.asset(
              imagelocation,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter, child: Text(imagecaption)),
          ),
        ),
      ),
    );
  }
}

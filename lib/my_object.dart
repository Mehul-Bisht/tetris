import 'package:flutter/material.dart';

class MyObject extends StatelessWidget {

  final color;

  const MyObject({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyScore extends StatelessWidget {

  final child;

  const MyScore({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: 80,
          height: 60,
          color: Colors.black,
          child: child,
        ),
      ),
    );
  }
}
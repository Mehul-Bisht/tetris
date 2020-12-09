import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final child;
  final function;

  const MyButton({Key key, this.child, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: 60,
            height: 60,
            color: Colors.black,
            child: child,
          ),
        ),
      ),
    );
  }
}
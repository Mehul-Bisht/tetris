import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {

  final child;
  final function;

  const StartButton({Key key, this.child, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: 100,
            height: 80,
            color: Colors.black,
            child: child,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  final Widget child;
  final Color color;
  const TagView({Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        // boxShadow: [
        //   BoxShadow(color: color, spreadRadius: 3),
        // ],
      ),
      child: child,
    );
  }
}

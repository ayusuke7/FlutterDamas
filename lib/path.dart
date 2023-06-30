import 'package:flutter/material.dart';

class Path extends StatelessWidget {

  final Color? color;

  const Path({ 
    super.key,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
    );
  }
}
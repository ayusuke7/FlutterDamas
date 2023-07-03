import 'package:flutter/material.dart';
import 'piece.dart';

class Square extends StatelessWidget {

  final Piece piece;
  final bool select;
  final bool debug;
  final bool checker;
  final Function()? onTap;

  const Square({ 
    super.key,
    this.onTap,
    this.select = false,
    this.debug = false,
    this.checker = false,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    Color color = select 
      ? Colors.green.shade600
      : Colors.brown.shade400;;
    
    Widget? child;

    if (piece.player) {

      var textColor = piece.black ? Colors.white : Colors.black;
      var textDebug = !debug ? null : Text("${piece.position}", 
        style: TextStyle(color: textColor)
      );

      child = CircleAvatar(
        radius: 30,
        backgroundColor: piece.color,
        child: !checker ? textDebug : Icon(Icons.star, 
          color: textColor
        ),
      );

    } else 
    if(debug) {
      child = Text("${piece.position}", 
        style: const TextStyle(
          color: Colors.white
        )
      );
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: child,
      ),
    );
  }
}
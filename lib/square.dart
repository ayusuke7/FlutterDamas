import 'package:flutter/material.dart';
import 'piece.dart';

class Square extends StatelessWidget {

  final Piece piece;
  final bool select;
  final Function()? onTap;

  const Square({ 
    super.key,
    this.onTap,
    this.select = false,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    Color color = select 
      ? Colors.green.shade600
      : Colors.brown.shade400;;
    Widget? child;

    if (piece.player) {
      child = CircleAvatar(
        radius: 30,
        backgroundColor: piece.color,
        child: Text(piece.label, style: TextStyle(
          color: piece.black 
            ? Colors.white 
            : Colors.black
        )),
      );
    } else {
      child = Text(piece.label, 
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
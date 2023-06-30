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
    Widget? child;
    Color color = Colors.yellow.shade50;

    if (piece.player) {
      color = select ? Colors.green.shade600 : Colors.brown.shade400;
      child = CircleAvatar(
        backgroundColor: piece.type == PieceType.black 
          ? Colors.black 
          : Colors.white,
        radius: 30,
        child: Text(piece.label, style: TextStyle(
          color: piece.type == PieceType.black 
            ? Colors.white 
            : Colors.black
        )),
      );
    } else 
    if(piece.type == PieceType.path){
      color = select ? Colors.green.shade600 : Colors.brown.shade400;
      child = Text(piece.label, style: const TextStyle(
        color: Colors.white
      ));
    } else 
    if(piece.type == PieceType.target){
      color = Colors.green.shade600;
      child = Text(piece.label, style: const TextStyle(
        color: Colors.white
      ));
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
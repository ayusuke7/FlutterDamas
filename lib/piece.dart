import 'package:flutter/material.dart';

enum PieceType {
  black,
  white,
  path,
  empty,
  target,
}

class PieceModel {

  PieceType? type;
  int position;
  
  PieceModel({
    this.type = PieceType.empty,
    required this.position
  });

  int get row => position ~/ 8;

  int get col => position % 8;

  bool get path => (col + row) % 2 == 0;

  bool get player => type == PieceType.black || type == PieceType.white;

  String get label => "$position";

  void log() {
    print("($row, $col) / $position / ${type?.name}");
  }

}

class Piece extends StatelessWidget {

  final PieceModel piece;
  final bool select;
  final Function()? onTap;

  const Piece({ 
    super.key,
    this.onTap,
    this.select = false,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {

    Widget? child;
    Color color = Colors.yellow.shade50;

    if (piece.type == PieceType.black || piece.type == PieceType.white) {
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
      color = Colors.brown.shade400;
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
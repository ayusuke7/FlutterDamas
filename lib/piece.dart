import 'package:flutter/material.dart';

enum PieceType {
  path,
  black,
  white,
}

enum PieceSide {
  left,
  right
}

class Piece {

  int position;
  int type;
  
  Piece({
    required this.position,
    required this.type,
  });

  int get row => position ~/ 8;

  int get col => position % 8;
  
  bool get player => pieceType != PieceType.path;

  bool get black => pieceType == PieceType.black;
  
  bool get white => pieceType == PieceType.white;
  
  PieceType get pieceType => PieceType.values[type-1];

  PieceSide get pieceSide => col >= 4 ? PieceSide.right : PieceSide.left;

  String get name => pieceType.name.characters.first.toUpperCase();

  String get label => "$position";

  Color get color {
    if (pieceType == PieceType.black) {
      return Colors.black;
    } else
    if (pieceType == PieceType.white) {
      return Colors.white;
    } else  {
      return Colors.brown.shade400;
    }
  }

  List<int> get targets {
    List<int> temp = [];
    if (white) {
      // superior à esquerda
      if (col > 0) {
        int topLeft = (row - 1) * 8 + (col - 1);
        temp.add(topLeft);
      }
      // superior à direita
      if (col < 7) {
        int topRight = (row - 1) * 8 + (col + 1);
        temp.add(topRight);
      }
    } else
    if (black) {
      // inferior à esquerda 
      if (col > 0) {
        int bottomLeft = (row + 1) * 8 + (col - 1);
        temp.add(bottomLeft);
      }
      // inferior à direita
      if (col < 7) {
        int bottomRight = (row + 1) * 8 + (col + 1);
        temp.add(bottomRight);
      }
    }
    return temp;
  }

  void log() {
    print("($row, $col) / $position / ${pieceType.name} / ${pieceSide.name}");
  }



}
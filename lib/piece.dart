import 'package:flutter/material.dart';

enum PieceType {
  path,
  black,
  white,
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

  List<List<int>> get diagonais {
    List<List<int>> positions = [[],[],[],[]];

    // superior à esquerda
    int leftTopRow = row;
    int leftTopCol = col;

    while (leftTopRow > 0 && leftTopCol > 0) {
      int topLeft = (leftTopRow - 1) * 8 + (leftTopCol - 1);
      positions[0].add(topLeft);
      leftTopRow--;
      leftTopCol--;
    }

    // superior à direira
    int topRightRow = row;
    int topRightCol = col;

    while (topRightRow > 0 && topRightCol < 7) {
      int topRight = (topRightRow - 1) * 8 + (topRightCol + 1);
      positions[1].add(topRight);
      topRightRow--;
      topRightCol++;
    }

    // inferior à direita
    int rightBottomRow = row;
    int rightBottomCol = col;

    while (rightBottomRow < 7 && rightBottomCol < 7) {
      int bottomRight = (rightBottomRow + 1) * 8 + (rightBottomCol + 1);
      positions[2].add(bottomRight);
      rightBottomRow++;
      rightBottomCol++;
    }

    // inferior à esquerda
    int leftBottomRow = row;
    int leftBottomCol = col;

    while (leftBottomRow < 7 && leftBottomCol > 0) {
      int bottomLeft = (leftBottomRow + 1) * 8 + (leftBottomCol - 1);
      positions[3].add(bottomLeft);
      leftBottomRow++;
      leftBottomCol--;
    }

    return positions;
  }

  void log() {
    print("($row, $col) / $position / ${pieceType.name}");
  }

}
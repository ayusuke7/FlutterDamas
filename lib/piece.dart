import 'package:flutter/material.dart';

enum PieceType {
  empty,
  path,
  black,
  white,
  target,
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

  bool get path => type > 0;

  bool get player => pieceType == PieceType.black || pieceType == PieceType.white;
  
  PieceType get pieceType => PieceType.values[type];

  String get name => pieceType.name.characters.first.toUpperCase();

  String get label => "$position";

  void log() {
    print("($row, $col) / $position / ${pieceType.name}");
  }

}
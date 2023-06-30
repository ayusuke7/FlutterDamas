import 'package:flutter/material.dart';

enum PieceType {
  empty,
  path,
  black,
  white,
  target,
}

class Piece {

  PieceType? type;
  int position;
  
  Piece({
    this.type = PieceType.empty,
    required this.position
  });

  int get row => position ~/ 8;

  int get col => position % 8;

  int get num => type!.index;

  bool get path => (col + row) % 2 == 0;

  bool get player => type == PieceType.black || type == PieceType.white;

  String get label => "$position";

  String get name => type!.name.characters.first.toUpperCase();

  void log() {
    print("($row, $col) / $position / ${type?.name}");
  }

}
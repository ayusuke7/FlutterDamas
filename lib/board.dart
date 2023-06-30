import 'package:flutter/material.dart';
import 'package:flutter_damas/piece.dart';

class BoardGame extends StatefulWidget {

  const BoardGame({super.key});

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {

  List<int> board = [
    0,1,0,1,0,1,0,1,
    1,0,1,0,1,0,1,0,
    0,1,0,1,0,1,0,1,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    2,0,2,0,2,0,2,0,
    0,2,0,2,0,2,0,2,
    2,0,2,0,2,0,2,0,
  ];

  List<int> whitePieces = [41, 43, 45, 47, 48, 50, 52, 54, 57, 59, 61, 63];
  List<int> blackPieces = [0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22];
  List<int> targetPaths = [];

  int selectPiece = -1;

  List<int> rowColFromPos(int pos) {
    var row = pos ~/ 8;
    var col = pos % 8;
    return [row, col];
  }

  int posFromRowCol(int row, int col) {
    return row * 8 + col;
  }

  void _calculatePathTarget(PieceModel piece) {

    piece.log();
    
    List<int> targets = [];

    if (piece.type == PieceType.white) {
      // superior à esquerda / superior à direita
      var topLeft = (piece.row - 1) * 8 + (piece.col - 1);
      var topRight = (piece.row - 1) * 8 + (piece.col + 1);
      targets.addAll([ topLeft, topRight ]);
    
    } else {
      // superior à esquerda / superior à direita
      var bottomLeft = (piece.row + 1) * 8 + (piece.col - 1);
      var bottomRight = (piece.row + 1) * 8 + (piece.col + 1);
      print([ bottomLeft, bottomRight ]);
      targetPaths.addAll([ bottomLeft, bottomRight ]);
    }

    setState(() { 
      selectPiece = piece.position;
      targetPaths = targets;
    });

  }

  void _movePieceToPosition(PieceModel piece) {

  }

  void _onTapPiece(PieceModel piece) {
    _calculatePathTarget(piece);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: GridView.builder(
          itemCount: 64,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8
          ), 
          itemBuilder: (BuildContext ctx, int index) {
            var piece = PieceModel(position: index);

            if (piece.path) {
              if (blackPieces.contains(index)) {
                piece.type = PieceType.black;
              } else
              if (whitePieces.contains(index)) {
                piece.type = PieceType.white;
              } else 
              if (targetPaths.contains(index)) {
                piece.type = PieceType.target;
              } else {
                piece.type = PieceType.path;
              }
            } 

            return Piece(
              piece: piece,
              select: index == selectPiece,
              onTap: (){ _onTapPiece(piece); },
            );
          },
        ),
      ),
    );
  }

}
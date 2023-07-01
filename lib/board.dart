import 'package:flutter/material.dart';
import 'package:flutter_damas/piece.dart';
import 'package:flutter_damas/square.dart';

class BoardGame extends StatefulWidget {

  const BoardGame({super.key});

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {

  // List<Piece> board1 = List.generate(64, (pos){
  //   var piece = Piece(position: pos);
  //   var white = [41, 43, 45, 47, 48, 50, 52, 54, 57, 59, 61, 63];
  //   var black = [0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20, 22];
  //   if (black.contains(pos)) {
  //     piece.type = PieceType.black;
  //   } else
  //   if (white.contains(pos)) {
  //     piece.type = PieceType.white;
  //   } else 
  //   if (piece.path) {
  //     piece.type = PieceType.path;
  //   } 
  //   return piece;
  // });
  List<int> board = [
    2,0,2,0,2,0,2,0,
    0,2,0,2,0,2,0,2,
    2,0,2,0,2,0,2,0,
    0,1,0,1,0,1,0,1,
    1,0,1,0,1,0,1,0,
    0,3,0,3,0,3,0,3,
    3,0,3,0,3,0,3,0,
    0,3,0,3,0,3,0,3
  ];

  List<int> targetPaths = [];
  int selectPiece = -1;

  void _printBoard() {
    var str = '';

    for (var i=0; i<8; i++) {
      var pos = i * 8;
      str += '\n${board
        .getRange(pos, pos + 8)
        .map((b) => b > 0 ? '[$b]' : '   ')
        .join('')}';
    }

    print(str);
  }

  void _calculatePathTarget(Piece piece) {

    piece.log();
  
    List<int> targets = [];

    if (piece.pieceType == PieceType.white) {
      // superior à esquerda / superior à direita
      var topLeft = (piece.row - 1) * 8 + (piece.col - 1);
      var topRight = (piece.row - 1) * 8 + (piece.col + 1);
      print([ topLeft, topRight ]);
      targets.addAll([ topLeft, topRight ]);
    } else
    if (piece.pieceType == PieceType.black) {
      // inferior à esquerda / inferior à direita
      var bottomLeft = (piece.row + 1) * 8 + (piece.col - 1);
      var bottomRight = (piece.row + 1) * 8 + (piece.col + 1);
      print([ bottomLeft, bottomRight ]);
      targetPaths.addAll([ bottomLeft, bottomRight ]);
    }

    if (targets.isNotEmpty) {
      setState(() { 
        selectPiece = piece.position;
        targetPaths = targets;
      });
    }

  }

  void _movePieceToPosition(Piece piece) {
    
  }

  @override
  Widget build(BuildContext context) {

    _printBoard();
   
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: board.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8
          ), 
          itemBuilder: (BuildContext ctx, int pos) {
            Piece piece = Piece(
              position: pos,
              type: board[pos]
            );

            return Square(
              select: pos == selectPiece,
              piece: piece,
              onTap: (){},
            );
          },
        ),
      ),
    );
  }

  // Widget _boadGrid() {
  //   return GridView.builder(
  //     itemCount: board1.length,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 8
  //     ), 
  //     itemBuilder: (BuildContext ctx, int pos) {
  //       Piece piece = board1[pos];          
  //       return Square(
  //         select: pos == selectPiece,
  //         piece: piece,
  //         onTap: (){
  //           _calculatePathTarget(piece);
  //         },
  //       );
  //     },
  //   );
  // }

}
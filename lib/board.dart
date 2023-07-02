import 'package:flutter/material.dart';
import 'package:flutter_damas/piece.dart';
import 'package:flutter_damas/square.dart';

class BoardGame extends StatefulWidget {

  const BoardGame({super.key});

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {

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

  PieceType vez = PieceType.white;
  List<int> targetPaths = [];
  Piece? selectPiece;
  

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

  List<int> _checkNextPaths(Piece piece) {
    List<int> targets = [];

    if (piece.white) {
      // superior à esquerda
      int topLeft = (piece.row - 1) * 8 + (piece.col - 1);
      var topLeftPiece = Piece(position: topLeft, type: board[topLeft]);

      if (topLeftPiece.black) {
        targets.addAll(_checkNextPaths(topLeftPiece));
      } else {
        targets.add(topLeft);
      }
      
    }

    return targets;
  }

  void _checkNextPosition() {
    
  }

  void _calculatePathTarget(Piece piece) {

    //piece.log();
    List<int> targets = [];

    for (var p in piece.targets) {
      var target = Piece(position: p, type: board[p]);
      if (!target.player) {
        targets.add(p);
      } else {
        print(target.targets);
      }
    }
  

    // if (piece.white) {
    //   // superior à esquerda
    //   int topLeft = (piece.row - 1) * 8 + (piece.col - 1);
    //   if (board[topLeft] == 1) {
    //     targets.add(topLeft);
    //   }

    //   // superior à direita
    //   int topRight = (piece.row - 1) * 8 + (piece.col + 1);
    //   if (board[topRight] == 1) {
    //     targets.add(topRight);
    //   }
    // } else
    // if (piece.black) {
    //   // inferior à esquerda 
    //   int bottomLeft = (piece.row + 1) * 8 + (piece.col - 1);
    //   if (board[bottomLeft] == 1) {
    //     targets.add(bottomLeft);
    //   }

    //   // inferior à direita
    //   int bottomRight = (piece.row + 1) * 8 + (piece.col + 1);
    //   if (board[bottomRight] < 7) {
    //     targets.add(bottomRight);
    //   }
    // }

    //print(targets);
    
    if (targets.isNotEmpty) {
      setState(() { 
        selectPiece = piece;
        targetPaths = targets;
      });
    }

  }

  void _movePieceToPosition(Piece piece) {
    //piece.log();

    setState(() {
      board[selectPiece!.position] = 1;
      board[piece.position] = selectPiece!.type;
      selectPiece = null;
      targetPaths.clear();
      vez = vez == PieceType.black 
        ? PieceType.white 
        : PieceType.black;
    });
  }

  @override
  Widget build(BuildContext context) {   
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
            int type = board[pos];

            if (type > 0) {
              Piece piece = Piece(position: pos, type: type);
              bool target = targetPaths.contains(pos);
              bool select = pos == selectPiece?.position;
              return Square(
                piece: piece,
                select: target || select,
                onTap: (){
                  if (piece.player && piece.pieceType == vez) {
                    _calculatePathTarget(piece);
                  } else 
                  if(target){
                    _movePieceToPosition(piece);
                  }
                },
              );
            }

            return Container(
              color: Colors.yellow.shade100,
            );
          },
        ),
      ),
    );
  }

  
}
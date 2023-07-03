import 'package:flutter/material.dart';
import 'package:flutter_damas/piece.dart';
import 'package:flutter_damas/square.dart';

List<int> initialBoard = [
    2,0,2,0,2,0,2,0,
    0,2,0,2,0,1,0,2,
    2,0,2,0,2,0,2,0,
    0,1,0,1,0,1,0,1,
    1,0,2,0,1,0,1,0,
    0,3,0,3,0,3,0,3,
    1,0,3,0,3,0,3,0,
    0,3,0,3,0,3,0,3
  ];

class BoardGame extends StatefulWidget {

  const BoardGame({ super.key });

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {

  List<int> board = initialBoard;

  PieceType vez = PieceType.white;
  List<int> targetPaths = [];
  Piece? selectPiece;

  void _calculatePathTarget(Piece piece) {

    //piece.log();
    print(piece.diagonais);
    List<int> targets = []; 

    // percorre as listas de diagonais
    for (var i = 0; i < piece.diagonais.length; i++) {
      var diagonal = piece.diagonais[i];

      // percore cada posicao da diagonal
      for (var j = 0; j < diagonal.length; j++) {
        
        int pos = diagonal[j];
        
        // caso seja igual a mesma cor sai do loop;
        if(board[pos] == piece.type) break;

        // checa se posicao é pra trás
        bool canNotBack = piece.black 
          ? pos > piece.position
          : pos < piece.position;

        // verifica se é uma posicao de movimento 
        // e se o movimento não se para trás
        if (board[pos] == 1 && canNotBack){
          targets.add(pos); 

          // verifica se a poxima posicao é tábém é um path
          // senão também sai do loop
          if (diagonal.length > j+1 && 
            board[diagonal[j+1]] == 1) break;

        }

      }
    }

   
    print(targets);

    if (targets.isNotEmpty) {
      setState(() { 
        selectPiece = piece;
        targetPaths = targets;
      });
    }
  }

  void _movePieceToPosition(Piece piece) {

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
    const titleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold
    );
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("VEZ: ${vez.name}".toUpperCase(), style: titleStyle),
            const Text("PLACAR: B (0) x (0) W", style: titleStyle),
          ],
        ),
      ),
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

            // quadrados jogavéis
            if (type > 0) {
              Piece piece = Piece(position: pos, type: type);

              bool target = targetPaths.contains(pos);
              bool select = pos == selectPiece?.position;

              return Square(
                piece: piece,
                debug: true,
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

            // quadrados vazios
            return Container(
              color: Colors.yellow.shade100,
            );
          },
        ),
      ),
    );
  }
  
}
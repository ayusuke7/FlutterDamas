// Função para obter as posições possíveis para uma peça de dama se mover
List<List<int>> obterPosicoesPossiveis(List<List<int>> tabuleiro, int linha, int coluna) {
  List<List<int>> posicoesPossiveis = [];

  // Verificar se a posição atual contém uma peça
  if (tabuleiro[linha][coluna] != 0) {
    
    // Verificar os movimentos diagonais para frente
    if (linha - 1 >= 0) {
      // Verificar movimento diagonal superior esquerdo
      if (coluna - 1 >= 0 && tabuleiro[linha - 1][coluna - 1] == 0) {
        posicoesPossiveis.add([linha - 1, coluna - 1]);
      }
      // Verificar movimento diagonal superior direito
      if (coluna + 1 < tabuleiro[0].length && tabuleiro[linha - 1][coluna + 1] == 0) {
        posicoesPossiveis.add([linha - 1, coluna + 1]);
      }
    }

    // Verificar movimento diagonal inferior esquerdo
    if (linha + 1 < tabuleiro.length && coluna - 1 >= 0 && tabuleiro[linha + 1][coluna - 1] == 0) {
      posicoesPossiveis.add([linha + 1, coluna - 1]);
    }

    // Verificar movimento diagonal inferior direito
    if (linha + 1 < tabuleiro.length && coluna + 1 < tabuleiro[0].length && tabuleiro[linha + 1][coluna + 1] == 0) {
      posicoesPossiveis.add([linha + 1, coluna + 1]);
    }
    
  }

  return posicoesPossiveis;
}

// Exemplo de uso do algoritmo
void main() {
  // Exemplo de tabuleiro representado por uma matriz
  List<List<int>> tabuleiro = [
    [0, 1, 0, 1, 0],
    [1, 0, 1, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
  ];

  int linha = 1;
  int coluna = 2;

  List<List<int>> posicoesPossiveis = obterPosicoesPossiveis(tabuleiro, linha, coluna);

  print("Posições possíveis para a peça na posição ($linha, $coluna):");
  for (var posicao in posicoesPossiveis) {
    print("(${posicao[0]}, ${posicao[1]})");
  }
}

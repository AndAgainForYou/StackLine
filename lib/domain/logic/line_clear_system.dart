import '../../core/constants/game_constants.dart';
import '../entities/game_board.dart';

class LineClearResult {
  const LineClearResult({
    required this.clearedRows,
    required this.clearedCols,
    required this.totalLines,
  });

  final Set<int> clearedRows;
  final Set<int> clearedCols;
  final int totalLines;

  bool get hasClears => totalLines > 0;
}

class LineClearSystem {
  LineClearResult detect(GameBoard board) {
    final clearedRows = <int>{};
    final clearedCols = <int>{};

    for (var row = 0; row < GameConstants.boardSize; row++) {
      if (board.cells[row].every((cell) => cell != null)) {
        clearedRows.add(row);
      }
    }

    for (var col = 0; col < GameConstants.boardSize; col++) {
      var full = true;
      for (var row = 0; row < GameConstants.boardSize; row++) {
        if (board.cells[row][col] == null) {
          full = false;
          break;
        }
      }
      if (full) clearedCols.add(col);
    }

    return LineClearResult(
      clearedRows: clearedRows,
      clearedCols: clearedCols,
      totalLines: clearedRows.length + clearedCols.length,
    );
  }
}

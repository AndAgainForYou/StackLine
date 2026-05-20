import 'package:flutter_test/flutter_test.dart';
import 'package:stackline/core/constants/game_constants.dart';
import 'package:stackline/core/utils/board_layout.dart';

/// dragAnchor = Offset(w * cellSize * f, h * cellSize * f)  where f = dragAnchorFraction = 0.65
/// DragTargetDetails.offset = pointerGlobal − dragAnchor  (= feedbackTopLeft)
///
/// Expected behaviour: the board cell under the finger always belongs to the piece.

void main() {
  const f = GameConstants.dragAnchorFraction; // 0.65
  const cellSize = 40.0;
  const boardTopLeft = Offset.zero;

  ({int row, int col}) snap(
    double ptrCol,
    double ptrRow,
    int w,
    int h,
  ) {
    final feedbackTopLeft = Offset(
      (ptrCol - f * w) * cellSize,
      (ptrRow - f * h) * cellSize,
    );
    return snapPieceToGrid(
      boardTopLeft: boardTopLeft,
      cellSize: cellSize,
      feedbackTopLeft: feedbackTopLeft,
      pieceWidth: w,
      pieceHeight: h,
    );
  }

  group('1×1 piece', () {
    // anchorCellInPiece = floor(0.65 * 1) = 0 → piece col = fingerCol
    test('finger in cell 3 (early) → piece at col 3', () {
      final r = snap(3.1, 2.5, 1, 1);
      expect(r.col, 3);
      expect(r.row, 2);
    });

    test('finger in cell 3 (late) → piece at col 3', () {
      expect(snap(3.9, 2.5, 1, 1).col, 3);
    });

    test('finger crosses into cell 4 → piece jumps to col 4', () {
      expect(snap(4.0, 2.5, 1, 1).col, 4);
    });
  });

  group('3×1 piece', () {
    // anchorCellInPiece = floor(0.65 * 3) = 1 → col = fingerCol - 1
    test('finger at cell 4 → piece at col 3 (spans 3,4,5)', () {
      final r = snap(4.2, 0.5, 3, 1);
      expect(r.col, 3); // fingerCol=4, col=4-1=3
    });

    test('finger at cell 5 → piece at col 4', () {
      expect(snap(5.5, 0.5, 3, 1).col, 4);
    });
  });

  group('2×2 piece', () {
    // anchorCellInPiece = floor(0.65 * 2) = 1 → col = fingerCol - 1
    test('finger at (3,3) → piece at (2,2)', () {
      final r = snap(3.5, 3.5, 2, 2);
      expect(r.col, 2);
      expect(r.row, 2);
    });
  });

  group('board offset respected', () {
    test('non-zero boardTopLeft', () {
      const offset = Offset(16, 100);
      // finger at board cell (3, 2), 1×1 piece
      final feedbackTopLeft = Offset(
        16 + (3.4 - f) * cellSize,
        100 + (2.4 - f) * cellSize,
      );
      final result = snapPieceToGrid(
        boardTopLeft: offset,
        cellSize: cellSize,
        feedbackTopLeft: feedbackTopLeft,
        pieceWidth: 1,
        pieceHeight: 1,
      );
      expect(result.col, 3);
      expect(result.row, 2);
    });
  });
}

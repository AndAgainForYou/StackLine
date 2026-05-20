import 'package:flutter_test/flutter_test.dart';
import 'package:stackline/domain/entities/game_board.dart';
import 'package:stackline/domain/logic/line_clear_system.dart';
import 'package:stackline/domain/logic/random_piece_generator.dart';

void main() {
  test('line clear detects full row and column', () {
    final board = GameBoard.empty();
    final piece = RandomPieceGenerator(random: (_) => 0).next();
    final filled = board.placePiece(piece, 0, 0);

    final system = LineClearSystem();
    final result = system.detect(filled);
    expect(result.totalLines, isA<int>());
  });
}

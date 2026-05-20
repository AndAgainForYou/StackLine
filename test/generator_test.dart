import 'package:flutter_test/flutter_test.dart';
import 'package:stackline/domain/logic/random_piece_generator.dart';

void main() {
  test('never generates more than 3 identical pieces in a row', () {
    final generator = RandomPieceGenerator(random: (_) => 0);
    final types = List.generate(300, (_) => generator.next().type);

    for (var i = 0; i < types.length; i++) {
      var run = 1;
      for (var j = i + 1; j < types.length && types[j] == types[i]; j++) {
        run++;
      }
      expect(run, lessThanOrEqualTo(3), reason: 'Run of ${types[i]} at index $i');
    }
  });

  test('never generates more than 4 of the same type within 10 pieces', () {
    final generator = RandomPieceGenerator(random: (_) => 0);
    final types = List.generate(500, (_) => generator.next().type);

    for (var start = 0; start <= types.length - 10; start++) {
      final window = types.sublist(start, start + 10);
      final counts = <dynamic, int>{};
      for (final type in window) {
        counts[type] = (counts[type] ?? 0) + 1;
      }
      for (final count in counts.values) {
        expect(
          count,
          lessThanOrEqualTo(4),
          reason: 'Window starting at $start: $window',
        );
      }
    }
  });
}

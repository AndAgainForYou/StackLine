import 'package:flutter/material.dart';

import '../entities/block_piece.dart';
import '../entities/tetromino_type.dart';

class RandomPieceGenerator {
  RandomPieceGenerator({required this.random});

  static const int _windowSize = 10;
  static const int _maxSameTypeInWindow = 4;

  final int Function(int max) random;
  int _piecesGenerated = 0;
  TetrominoType? _lastType;
  int _sameTypeStreak = 0;
  final List<TetrominoType> _recentTypes = [];

  int get piecesGenerated => _piecesGenerated;

  BlockPiece next() {
    _piecesGenerated++;
    final type = _pickType();
    if (type == _lastType) {
      _sameTypeStreak++;
    } else {
      _lastType = type;
      _sameTypeStreak = 1;
    }
    _rememberType(type);
    return BlockPiece(
      id: '${DateTime.now().microsecondsSinceEpoch}_$_piecesGenerated',
      type: type,
      cells: _shapeFor(type),
      color: _colorFor(type),
    );
  }

  List<BlockPiece> nextBatch(int count) {
    return List.generate(count, (_) => next());
  }

  void restoreGenerationCount(int count) {
    _piecesGenerated = count;
    _lastType = null;
    _sameTypeStreak = 0;
    _recentTypes.clear();
  }

  TetrominoType _pickType() {
    final difficulty = (_piecesGenerated / 12).floor().clamp(0, 6);
    var pool = TetrominoType.values.where((type) {
      if (type.isRare) {
        final rareChance = (0.02 + difficulty * 0.015).clamp(0.02, 0.12);
        return random(1000) < (rareChance * 1000);
      }
      return type.difficultyWeight <= 3 + difficulty * 1.2;
    }).toList();

    if (pool.isEmpty) {
      pool = List<TetrominoType>.from(TetrominoType.values);
    }

    pool = _filterPool(pool);
    return pool[random(pool.length)];
  }

  List<TetrominoType> _filterPool(List<TetrominoType> pool) {
    var filtered = _applyWindowLimit(pool);
    filtered = _applyStreakLimit(filtered);
    if (filtered.isNotEmpty) return filtered;

    filtered = _applyWindowLimit(List<TetrominoType>.from(TetrominoType.values));
    filtered = _applyStreakLimit(filtered);
    if (filtered.isNotEmpty) return filtered;

    return _applyStreakLimit(List<TetrominoType>.from(TetrominoType.values));
  }

  /// At most 4 of the same type within any consecutive window of 10 pieces.
  List<TetrominoType> _applyWindowLimit(List<TetrominoType> pool) {
    if (_recentTypes.isEmpty) return pool;

    final counts = <TetrominoType, int>{};
    for (final type in _recentTypes) {
      counts[type] = (counts[type] ?? 0) + 1;
    }

    final filtered = pool
        .where((type) => (counts[type] ?? 0) < _maxSameTypeInWindow)
        .toList();
    return filtered.isNotEmpty ? filtered : pool;
  }

  void _rememberType(TetrominoType type) {
    _recentTypes.add(type);
    while (_recentTypes.length >= _windowSize) {
      _recentTypes.removeAt(0);
    }
  }

  /// Prevents more than 3 identical pieces in a row.
  List<TetrominoType> _applyStreakLimit(List<TetrominoType> pool) {
    if (_sameTypeStreak < 3 || _lastType == null) return pool;

    final filtered = pool.where((type) => type != _lastType).toList();
    if (filtered.isNotEmpty) return filtered;

    return TetrominoType.values.where((type) => type != _lastType).toList();
  }

  List<List<bool>> _shapeFor(TetrominoType type) {
    return switch (type) {
      TetrominoType.i => [
          [true, true, true, true],
        ],
      TetrominoType.o => [
          [true, true],
          [true, true],
        ],
      TetrominoType.t => [
          [false, true, false],
          [true, true, true],
        ],
      TetrominoType.s => [
          [false, true, true],
          [true, true, false],
        ],
      TetrominoType.z => [
          [true, true, false],
          [false, true, true],
        ],
      TetrominoType.j => [
          [true, false, false],
          [true, true, true],
        ],
      TetrominoType.l => [
          [false, false, true],
          [true, true, true],
        ],
      TetrominoType.dot => [
          [true],
        ],
      TetrominoType.domino => [
          [true, true],
        ],
      TetrominoType.l3 => [
          [true, false],
          [true, true],
        ],
      TetrominoType.square3 => [
          [true, true, true],
          [true, true, true],
          [true, true, true],
        ],
      TetrominoType.cross => [
          [false, true, false],
          [true, true, true],
          [false, true, false],
        ],
      TetrominoType.bigL => [
          [true, false],
          [true, false],
          [true, true],
        ],
    };
  }

  Color _colorFor(TetrominoType type) {
    return switch (type) {
      TetrominoType.i => const Color(0xFF00E5FF),
      TetrominoType.o => const Color(0xFFFFD600),
      TetrominoType.t => const Color(0xFFAA00FF),
      TetrominoType.s => const Color(0xFF00E676),
      TetrominoType.z => const Color(0xFFFF5252),
      TetrominoType.j => const Color(0xFF448AFF),
      TetrominoType.l => const Color(0xFFFF9100),
      TetrominoType.dot => const Color(0xFF80CBC4),
      TetrominoType.domino => const Color(0xFFAED581),
      TetrominoType.l3 => const Color(0xFFCE93D8),
      TetrominoType.square3 => const Color(0xFFFF8A80),
      TetrominoType.cross => const Color(0xFFFF4081),
      TetrominoType.bigL => const Color(0xFF7C4DFF),
    };
  }
}

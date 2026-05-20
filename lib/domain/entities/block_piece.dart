import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'tetromino_type.dart';

class BlockPiece extends Equatable {
  const BlockPiece({
    required this.id,
    required this.type,
    required this.cells,
    required this.color,
  });

  final String id;
  final TetrominoType type;
  final List<List<bool>> cells;
  final Color color;

  int get width => cells.isEmpty ? 0 : cells.first.length;
  int get height => cells.length;

  List<Offset> get occupiedOffsets {
    final offsets = <Offset>[];
    for (var row = 0; row < height; row++) {
      for (var col = 0; col < width; col++) {
        if (cells[row][col]) {
          offsets.add(Offset(col.toDouble(), row.toDouble()));
        }
      }
    }
    return offsets;
  }

  BlockPiece rotated() {
    if (cells.isEmpty) return this;
    final rotatedCells = List.generate(
      width,
      (col) => List.generate(height, (row) => cells[height - 1 - row][col]),
    );
    return BlockPiece(
      id: id,
      type: type,
      cells: rotatedCells,
      color: color,
    );
  }

  @override
  List<Object?> get props => [id, type, cells, color];
}

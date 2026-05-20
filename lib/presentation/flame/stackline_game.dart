import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../features/game/bloc/game_state.dart';
import '../widgets/board_painter.dart';

/// Flame-backed board renderer used inside [GameBoardView].
class StacklineFlameBoard extends FlameGame {
  StacklineFlameBoard({
    required this.state,
    required this.theme,
    required this.clearFlash,
  });

  GameState state;
  BoardTheme theme;
  double clearFlash;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(BoardRenderComponent(
      state: state,
      theme: theme,
      clearFlash: clearFlash,
    ));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    for (final component in children.whereType<BoardRenderComponent>()) {
      component
        ..size = size
        ..position = Vector2.zero();
    }
  }

  void refresh({
    required GameState nextState,
    required BoardTheme nextTheme,
    required double nextClearFlash,
  }) {
    state = nextState;
    theme = nextTheme;
    clearFlash = nextClearFlash;
    children.whereType<BoardRenderComponent>().firstOrNull?.refresh(
          state: state,
          theme: theme,
          clearFlash: clearFlash,
        );
  }
}

class BoardTheme {
  const BoardTheme({
    required this.isDark,
    required this.boardBackground,
    required this.gridColor,
  });

  final bool isDark;
  final Color boardBackground;
  final Color gridColor;
}

class BoardRenderComponent extends PositionComponent with HasGameReference {
  BoardRenderComponent({
    required this.state,
    required this.theme,
    required this.clearFlash,
  });

  GameState state;
  BoardTheme theme;
  double clearFlash;

  void refresh({
    required GameState state,
    required BoardTheme theme,
    required double clearFlash,
  }) {
    this.state = state;
    this.theme = theme;
    this.clearFlash = clearFlash;
  }

  @override
  void render(Canvas canvas) {
    final painter = BoardPainter(
      board: state.board,
      clearingRows: state.clearingRows,
      clearingCols: state.clearingCols,
      isDark: theme.isDark,
      boardBackground: theme.boardBackground,
      gridColor: theme.gridColor,
      clearFlash: clearFlash,
    );

    painter.paint(canvas, Size(size.x, size.y));
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}

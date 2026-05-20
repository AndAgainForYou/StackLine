import '../../core/constants/game_constants.dart';

class ScoreResult {
  const ScoreResult({
    required this.pointsEarned,
    required this.comboMultiplier,
    required this.nextComboMultiplier,
  });

  final int pointsEarned;
  final double comboMultiplier;
  final double nextComboMultiplier;
}

class ScoreSystem {
  int calculateLineScore({
    required int linesCleared,
    required double comboMultiplier,
    required int difficultyLevel,
  }) {
    if (linesCleared == 0) return 0;

    final base = linesCleared * GameConstants.baseLineScore;
    final multiLineBonus = linesCleared > 1 ? linesCleared * 50 : 0;
    final difficultyBonus = difficultyLevel * 25 * linesCleared;

    return ((base + multiLineBonus + difficultyBonus) * comboMultiplier).round();
  }

  ScoreResult applyClear({
    required int linesCleared,
    required double currentComboMultiplier,
    required int difficultyLevel,
  }) {
    if (linesCleared == 0) {
      return ScoreResult(
        pointsEarned: 0,
        comboMultiplier: currentComboMultiplier,
        nextComboMultiplier: 1.0,
      );
    }

    final points = calculateLineScore(
      linesCleared: linesCleared,
      comboMultiplier: currentComboMultiplier,
      difficultyLevel: difficultyLevel,
    );

    return ScoreResult(
      pointsEarned: points,
      comboMultiplier: currentComboMultiplier,
      nextComboMultiplier: currentComboMultiplier + GameConstants.comboMultiplierStep,
    );
  }

  int placementBonus(int cellCount) => cellCount * 5;
}
